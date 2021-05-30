import 'package:flutter/material.dart';
import 'package:patient_app/Doctor/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:patient_app/Doctor/src/global_bloc.dart';
import 'package:patient_app/Doctor/src/ui/homepage/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MedicineReminder());
}

class MedicineReminder extends StatefulWidget with NavigationStates {
  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  GlobalBloc globalBloc;

  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        home: MedHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
