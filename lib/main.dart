import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:local_json_read/models/home.dart';
import 'package:local_json_read/screens/emial_auth.dart';
import 'package:local_json_read/screens/stack_images.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyA1oW-SYzcCWrjbeqEF3p9W4HQQcqhydak',
          appId: '1:226145979557:android:bd477403af9d5349e7914c',
          messagingSenderId: '226145979557',
          projectId: 'local-json-read'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageZooming(),
    );
  }
}
