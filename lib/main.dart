import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:otpauth/otpverify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: otpverify(),
  ));
}
