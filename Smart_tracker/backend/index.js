const express = require('express');
const multer = require('multer');
const cors = require('cors');
const path = require('path');
const fs = require('fs');

const app = express();
const port = 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use('/uploads', express.static('uploads'));

// Ensure uploads folder exists
if (!fs.existsSync('uploads')) {
  fs.mkdirSync('uploads');
}

// In-memory storage
let activities = [];
let nextId = 1;

// Multer configuration
const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, 'uploads/'),
  filename: (req, file, cb) => cb(null, Date.now() + '-' + file.originalname)
});
const upload = multer({ storage });

// Routes
app.get('/api/activities', (req, res) => {
  res.json(activities);
});

app.post('/api/activities', upload.single('image'), (req, res) => {
  const { latitude, longitude, timestamp } = req.body;
  const imageUrl = req.file ? `/uploads/${req.file.filename}` : null;

  const activity = {
    id: nextId++,
    latitude: parseFloat(latitude),
    longitude: parseFloat(longitude),
    image_url: imageUrl,
    timestamp
  };

  activities.unshift(activity);
  res.status(201).json(activity);
});

app.delete('/api/activities/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const index = activities.findIndex(a => a.id === id);

  if (index >= 0) {
    activities.splice(index, 1);
    res.json({ message: 'Deleted successfully' });
  } else {
    res.status(404).json({ message: 'Activity not found' });
  }
});

app.listen(port, () => {
  console.log(`🚀 SmartTracker API running on http://localhost:${port}`);
  console.log(`📱 Android Emulator: http://10.0.2.2:${port}`);
});
