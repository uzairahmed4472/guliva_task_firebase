import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guliva_interview_task/pages/addVehicle_screen.dart';
import 'package:guliva_interview_task/pages/login_screen.dart';
import 'package:guliva_interview_task/pages/signup_screen.dart';
import 'package:guliva_interview_task/pages/vehicleDetails_screen.dart';
import 'package:guliva_interview_task/pages/vehicles_screen.dart';

void main() async {
  WidgetsFlutterBinding();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: "AIzaSyBH1dWu02hN0lfGYzSSvcNMpTPwQTrwopg",
            appId: "1:274998705127:android:be5fdc6fb1d0993d225b42",
            messagingSenderId: "274998705127",
            projectId: "guliva-app",
          ),
        )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        VehiclesScreen.id: (context) => VehiclesScreen(),
        VehicleDetailsScreen.id: (context) => VehicleDetailsScreen(),
        AddVehicleScreen.id: (context) => AddVehicleScreen(),
      },
    );
  }
}
