import 'package:flutter/material.dart';





class VehicleDetailsScreen extends StatelessWidget {
  static String id = 'vehicleDetails_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/guliva_logo.png', height: 40),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Toyota',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: Colors.blue,
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'Details'),
                      Tab(text: 'Trips'),
                      Tab(text: 'Insurance'),
                    ],
                  ),
                  SizedBox(
                    height: 400, // Adjust as necessary
                    child: TabBarView(
                      children: [
                        VehicleDetailsTab(),
                        Center(child: Text('Trips')),
                        Center(child: Text('Insurance')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VehicleDetailsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailRow(label: 'Name of vehicle', value: 'Toyota'),
          DetailRow(label: 'Model', value: 'Camry'),
          DetailRow(label: 'Color', value: 'Yellow'),
          DetailRow(label: 'Year', value: '2008'),
          DetailRow(label: 'Primary Driver', value: 'JamesIdowu'),
          SizedBox(height: 16),
          Text(
            'Photo attached',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Image.asset('assets/car_front.png', width: 50),
              SizedBox(width: 8),
              Image.asset('assets/car_back.png', width: 50),
              SizedBox(width: 8),
              Image.asset('assets/car_side.png', width: 50),
              SizedBox(width: 8),
              Image.asset('assets/car_top.png', width: 50),
            ],
          ),
          SizedBox(height: 16),
          DetailRow(label: 'Total Distance Covered (km)', value: '0.01'),
          DetailRow(label: 'Amount Billed', value: '0.04'),
        ],
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
