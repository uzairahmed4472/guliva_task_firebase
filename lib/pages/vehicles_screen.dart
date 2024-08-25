import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guliva_interview_task/pages/addVehicle_screen.dart';
import 'dart:async';

import 'package:guliva_interview_task/models/addVehicle_model.dart';

// Global stream controller for vehicle data
final StreamController<List<AddVehicle>> _vehiclesStreamController =
    StreamController<List<AddVehicle>>.broadcast();

class VehiclesScreen extends StatefulWidget {
  static String id = 'home_screen';

  @override
  _VehiclesScreenState createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final User? user = FirebaseAuth.instance.currentUser;
  late final userId;
  getStreamData() async {
    final stream = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection('vehicles')
        .snapshots();
    return stream;
  }

  @override
  void initState() {
    super.initState();
    userId = user!.uid;
    _tabController = TabController(length: 2, vsync: this);
    // Add initial data to the stream
  }

  @override
  void dispose() {
    // _vehiclesStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset(
          'assets/images/guliva_logo_1.png',
          height: 40,
          color: Colors.blue,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "Vehicles"),
              Tab(text: "Passengers"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .collection('vehicles')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final vehicles = snapshot.data!.docs;
                    print(vehicles);
                    return ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: vehicles.length,
                        itemBuilder: (context, index) {
                          var vehicle =
                              vehicles[index].data() as Map<String, dynamic>;
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Icon(Icons.directions_car),
                              ),
                              title:
                                  Text(vehicle['nameOfVehicle'] ?? 'No Name'),
                              subtitle:
                                  Text(vehicle['model'] ?? 'Unknown Model'),
                              onTap: () {
                                // Handle vehicle tap
                              },
                            ),
                          );
                        });
                  },
                ),
                Center(
                  child: Text('Passengers'),
                ), // Placeholder for Passengers tab
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddVehicleScreen.id).then((_) {
                  // Update the stream when returning from AddVehicleScreen
                  _vehiclesStreamController.add(vehiclesList);
                });
              },
              child: Text(
                "ADD VEHICLE",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                backgroundColor: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
