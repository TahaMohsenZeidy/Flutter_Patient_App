import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:patient_app/Radiologist/bloc.navigation_bloc/navigation_bloc.dart';

class data extends StatefulWidget with NavigationStates {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<data> {
  bool isFirstTime = false;
  bool isLoading = true;
  List<Widget> topHeader;
  List<Widget> currentAppointment;
  List<Widget> midHeader;
  List<Widget> futureAppointment;
  List<Widget> finalList;

  Widget build(BuildContext context) {
    StreamBuilder getAA() {
      return new StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('patients')
              .doc('EtmKnqyPBMV4tH7hx8DpWUFWf462')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            }
            var userDocument = snapshot.data;
            return new Text(userDocument["age"] +
                userDocument["cin"] +
                userDocument["description"]);
          });
    }
  }
}
