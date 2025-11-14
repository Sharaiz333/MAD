import 'package:flutter/material.dart';
import '../models/device.dart';
import '../widgets/device_card.dart';
import '../widgets/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Device> devices = [
    Device(name: "Living Room Light", icon: "💡"),
    Device(name: "Air Conditioner", icon: "❄️"),
    Device(name: "Smart TV", icon: "📺"),
    Device(name: "Heater", icon: "🔥"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverSafeArea(
            sliver: SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Smart Home Dashboard"),
              ),
            ),
          ),

          // Sliver List (ListView)
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SectionTitle(title: "Your Devices (ListView + ListTile)"),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    final device = devices[index];
                    return Dismissible(
                      key: ValueKey(device.name),
                      background: Container(color: Colors.red),
                      onDismissed: (_) {
                        setState(() {
                          devices.removeAt(index);
                        });
                      },
                      child: Card(
                        child: ListTile(
                          leading: Text(device.icon, style: const TextStyle(fontSize: 24)),
                          title: Text(device.name),
                          subtitle: Text(device.isOn ? "ON" : "OFF"),
                          trailing: Switch(
                            value: device.isOn,
                            onChanged: (value) {
                              setState(() {
                                device.isOn = value;
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SectionTitle(title: "GridView.count"),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  children: devices.map((d) => DeviceCard(device: d)).toList(),
                ),

                const SectionTitle(title: "GridView.extent"),
                GridView.extent(
                  shrinkWrap: true,
                  maxCrossAxisExtent: 200,
                  physics: const NeverScrollableScrollPhysics(),
                  children: devices.map((d) => DeviceCard(device: d)).toList(),
                ),

                const SectionTitle(title: "GridView.builder"),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: devices.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return DeviceCard(device: devices[index]);
                  },
                ),
              ],
            ),
          ),

          // Sliver Grid
          const SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverGrid(
              delegate: SliverChildListDelegate.fixed([
                Card(child: Center(child: Text("Sliver Grid Item 1"))),
                Card(child: Center(child: Text("Sliver Grid Item 2"))),
                Card(child: Center(child: Text("Sliver Grid Item 3"))),
                Card(child: Center(child: Text("Sliver Grid Item 4"))),
              ]),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
            ),
          ),
        ],
      ),
    );
  }
}
