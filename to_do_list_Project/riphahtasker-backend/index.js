// server.js

// 1. Setup Environment Variables and Dependencies
require('dotenv').config();
const express = require('express');
const cors = require('cors');
const admin = require('firebase-admin');
const axios = require('axios');

// 2. Initialize Firebase Admin SDK
// This uses the serviceAccountKey.json you downloaded
const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  // Replace with your project ID
  databaseURL: `https://${serviceAccount.project_id}.firebaseio.com`
});

const db = admin.firestore();
const app = express();
const PORT = process.env.PORT || 3000;
const OPENWEATHER_API_KEY = process.env.OPENWEATHER_API_KEY;
const FAVQS_API_URL = process.env.FAVQS_API_URL;

// 3. Middlewares
// Allow cross-origin requests
app.use(cors());
// Parse JSON bodies for POST requests
app.use(express.json());


// -----------------------------------------------------
// 4. API Endpoints for Task Management (Firebase)
// -----------------------------------------------------

/**
 * Endpoint to add a new task.
 * @route POST /api/tasks
 */
app.post('/api/tasks', async (req, res) => {
  try {
    const { title, description } = req.body;
    if (!title) {
      return res.status(400).send({ message: 'Title is required' });
    }

    const newTask = {
      title,
      description: description || '',
      isDone: false,
      created: admin.firestore.FieldValue.serverTimestamp(),
    };

    const docRef = await db.collection('tasks').add(newTask);
    res.status(201).send({
      id: docRef.id,
      ...newTask,
      created: null // Send null for timestamp since we can't send a ServerTimestamp object
    });

  } catch (error) {
    console.error('Error adding task:', error);
    res.status(500).send({ message: 'Internal server error' });
  }
});

/**
 * Endpoint to update a task (title, description, or isDone status).
 * @route PUT /api/tasks/:id
 */
app.put('/api/tasks/:id', async (req, res) => {
  try {
    const taskId = req.params.id;
    const updateData = req.body;

    await db.collection('tasks').doc(taskId).update(updateData);
    res.status(200).send({ message: 'Task updated successfully' });

  } catch (error) {
    console.error('Error updating task:', error);
    res.status(500).send({ message: 'Internal server error' });
  }
});

/**
 * Endpoint to delete a task.
 * @route DELETE /api/tasks/:id
 */
app.delete('/api/tasks/:id', async (req, res) => {
  try {
    const taskId = req.params.id;
    await db.collection('tasks').doc(taskId).delete();
    res.status(200).send({ message: 'Task deleted successfully' });

  } catch (error) {
    console.error('Error deleting task:', error);
    res.status(500).send({ message: 'Internal server error' });
  }
});

/**
 * Endpoint to stream all tasks.
 * NOTE: For full compatibility with Flutter StreamBuilder, we'll implement a polling mechanism,
 * which is simpler for a basic Node.js setup than actual real-time streams (WebSockets).
 * However, the Flutter client will now just fetch data periodically.
 * @route GET /api/tasks
 */
app.get('/api/tasks', async (req, res) => {
  try {
    const { filter } = req.query; // 'all', 'completed', 'pending'
    let query = db.collection('tasks').orderBy('created', 'asc');

    if (filter === 'completed') {
      query = query.where('isDone', '==', true);
    } else if (filter === 'pending') {
      query = query.where('isDone', '==', false);
    }

    const snapshot = await query.get();

    const tasks = snapshot.docs.map(doc => ({
      id: doc.id,
      ...doc.data(),
      // Convert Firebase Timestamp to something JSON-serializable
      created: doc.data().created ? doc.data().created.toDate().toISOString() : null
    }));

    res.status(200).send(tasks);

  } catch (error) {
    console.error('Error fetching tasks:', error);
    res.status(500).send({ message: 'Internal server error' });
  }
});


// -----------------------------------------------------
// 5. API Endpoint for External Services (Weather & Quote)
// -----------------------------------------------------

/**
 * Endpoint to fetch weather and a daily quote.
 * @route GET /api/external-data
 */
app.get('/api/external-data', async (req, res) => {
  const city = req.query.city || 'Islamabad';
  const data = {
    city,
    weather: "Unavailable",
    description: "",
    temp: null,
    dailyQuote: "Opportunities don't happen, you create them.",
    quoteAuthor: "Chris Grosser"
  };

  // Fetch Weather
  try {
    const weatherUrl = `https://api.openweathermap.org/data/2.5/weather?q=${city}&units=metric&appid=${OPENWEATHER_API_KEY}`;
    const weatherResponse = await axios.get(weatherUrl, { timeout: 7000 });

    if (weatherResponse.status === 200) {
      const weatherData = weatherResponse.data;
      data.temp = weatherData.main.temp;
      data.weather = weatherData.weather[0].main;
      data.description = weatherData.weather[0].description;
    }
  } catch (error) {
    console.error('Weather API error:', error.message);
  }

  // Fetch Daily Quote
  try {
    const quoteResponse = await axios.get(FAVQS_API_URL, { timeout: 7000 });

    if (quoteResponse.status === 200) {
      const quote = quoteResponse.data.quote;
      data.dailyQuote = quote.body || data.dailyQuote;
      data.quoteAuthor = quote.author || data.quoteAuthor;
    }
  } catch (error) {
    console.error('Quote API error:', error.message);
  }

  res.status(200).send(data);
});


// -----------------------------------------------------
// 6. Start Server
// -----------------------------------------------------

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
  console.log(`Backend URL: http://localhost:${PORT}`);
});