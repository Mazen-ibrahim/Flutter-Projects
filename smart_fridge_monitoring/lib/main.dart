import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_fridge_monitoring/firebase_options.dart';
import 'package:smart_fridge_monitoring/widgets/smart_fridge.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, // Required for desktop/web
    );
    log("✅ Firebase Initialized Successfully!");
  } catch (e) {
    log("❌ Firebase Initialization Error: $e");
  }
  runApp(const SmartFridge());
}
