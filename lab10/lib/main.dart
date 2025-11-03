import 'package:flutter/material.dart';

void main() {
  runApp(VehicleApp());
}

class VehicleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vehicle Management System',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: VehicleHome(),
    );
  }
}

class VehicleHome extends StatefulWidget {
  @override
  State<VehicleHome> createState() => _VehicleHomeState();
}

class _VehicleHomeState extends State<VehicleHome> {
  List<String> vehicles = List.generate(5, (index) => 'Vehicle ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar with image
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Vehicle Management System'),
              background: Image.network(
                'https://picsum.photos/id/1018/400/200',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Safe Area for main content
          SliverSafeArea(
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // Stack Example
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 120,
                      color: Colors.blueGrey[100],
                    ),
                    const Text(
                      'Welcome to Vehicle Dashboard',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Vehicle Information Card
                Card(
                  margin: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 150,
                    child: ListView(
                      children: const [
                        ListTile(
                          leading:
                          Icon(Icons.directions_car, color: Colors.blue),
                          title: Text('Car'),
                          subtitle: Text('Type: Sedan'),
                        ),
                        ListTile(
                          leading: Icon(Icons.two_wheeler, color: Colors.green),
                          title: Text('Motorbike'),
                          subtitle: Text('Type: Sports'),
                        ),
                      ],
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Available Vehicles (GridView.count)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                // GridView.count Example
                SizedBox(
                  height: 150,
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(
                      6,
                          (index) => Card(
                        color: Colors.blueGrey[(index + 2) * 100],
                        child: Center(child: Text('Vehicle $index')),
                      ),
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Garage Sections (GridView.extent)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                // GridView.extent Example
                SizedBox(
                  height: 150,
                  child: GridView.extent(
                    maxCrossAxisExtent: 100,
                    children: List.generate(
                      6,
                          (index) => Card(
                        color: Colors.green[(index + 2) * 100],
                        child: Center(child: Text('Garage $index')),
                      ),
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Maintenance Slots (GridView.builder)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                // GridView.builder Example
                SizedBox(
                  height: 150,
                  child: GridView.builder(
                    itemCount: 6,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) => Card(
                      color: Colors.purple[(index + 2) * 100],
                      child: Center(child: Text('Slot $index')),
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Vehicles in List (Dismissible)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                // Dismissible list for vehicles
                Column(
                  children: vehicles.map((vehicle) {
                    return Dismissible(
                      key: Key(vehicle),
                      background: Container(color: Colors.red),
                      onDismissed: (direction) {
                        setState(() {
                          vehicles.remove(vehicle);
                        });
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(vehicle),
                          subtitle: const Text('Swipe to remove'),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ]),
            ),
          ),

          // SliverGrid Example
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => Card(
                color: Colors.orange[(index + 2) * 100],
                child: Center(child: Text('Report $index')),
              ),
              childCount: 6,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
          ),
        ],
      ),
    );
  }
}
