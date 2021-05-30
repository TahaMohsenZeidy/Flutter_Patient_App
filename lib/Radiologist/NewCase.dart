import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:patient_app/Scan_generate_QR/Scan.dart';
import 'package:patient_app/Radiologist/bloc.navigation_bloc/navigation_bloc.dart';

class NewCase extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    var patient;
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        padding: EdgeInsets.only(bottom: 150),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                "The different types of images ",
                style: TextStyle(
                  fontFamily: 'signatra',
                ),
              ),
            ),
            SizedBox(
              height: 150,
            ),
            Container(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: RaisedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // builder: (_) => PatientDetails(restaurant: patient),
                    ),
                  ),
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Radio thorax",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Container(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: RaisedButton(
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => new ScanPage()))
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "AUSP",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Container(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: RaisedButton(
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => new ScanPage()))
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "TOGD",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: RaisedButton(
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => new ScanPage()))
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "LB",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Container(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: RaisedButton(
                // onPressed: () => {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (BuildContext context) =>
                //               new PatientDetails()))
                // },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "TG",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
