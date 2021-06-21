import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Login.dart';
import 'SignUp.dart';
import 'Start.dart';

var usersRef = FirebaseFirestore.instance.collection("users");
var patientsRef = FirebaseFirestore.instance.collection("patients");
var doctorsRef = FirebaseFirestore.instance.collection("Full_Profile_Doc");
var docsRef = FirebaseFirestore.instance.collection("doctors");
var appointementsRef = FirebaseFirestore.instance.collection("Appointments");
var currentUsr = FirebaseAuth.instance.currentUser;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        "Login": (BuildContext context) => Login(),
        "SignUp": (BuildContext context) => SignUp(),
        "start": (BuildContext context) => Start(),
      },
    );
  }
}
