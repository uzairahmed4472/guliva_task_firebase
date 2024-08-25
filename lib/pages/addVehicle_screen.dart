import 'package:flutter/material.dart';
import 'package:guliva_interview_task/models/addVehicle_model.dart';
  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Global list to store vehicle data
List<AddVehicle> vehiclesList = [];

class AddVehicleScreen extends StatefulWidget {
  static String id = 'addVehicle_screen';

  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  final AddVehicle _vehicle = AddVehicle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Vehicle',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Type of vehicle',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    DropdownMenuItem(child: Text('Car'), value: 'Car'),
                    DropdownMenuItem(child: Text('Truck'), value: 'Truck'),
                    DropdownMenuItem(
                        child: Text('Motorcycle'), value: 'Motorcycle'),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _vehicle.typeOfVehicle = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a vehicle type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name of vehicle',
                    hintText: 'e.g. Benz AL340',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _vehicle.nameOfVehicle = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name of the vehicle';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Model',
                    hintText: 'e.g. AL340',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _vehicle.model = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the model';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Color',
                    hintText: 'e.g. black',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _vehicle.color = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the color';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Year',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _vehicle.year = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the year';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Value of Vehicle',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _vehicle.valueOfVehicle = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the value of the vehicle';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveVehicle();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Vehicle added successfully!')),
                      );
                      // Optionally, navigate back or clear the form here
                      // Navigator.pop(context);
                    }
                  },
                  child: Text('Add Vehicle'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }




void _saveVehicle() async {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    // Handle the case where the user is not logged in
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User not logged in.')),
    );
    return;
  }

  final userId = user.uid;
  final CollectionReference vehiclesCollection =
      FirebaseFirestore.instance.collection('users').doc(userId).collection('vehicles');

  try {
    await vehiclesCollection.add({
      'typeOfVehicle': _vehicle.typeOfVehicle,
      'nameOfVehicle': _vehicle.nameOfVehicle,
      'model': _vehicle.model,
      'color': _vehicle.color,
      'year': _vehicle.year,
      'valueOfVehicle': _vehicle.valueOfVehicle,
    });
    setState(() {
      vehiclesList.add(_vehicle);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Vehicle added successfully!')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to add vehicle: $e')),
    );
  }
}

}
