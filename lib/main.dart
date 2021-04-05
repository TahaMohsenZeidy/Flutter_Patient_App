import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:patient_app/Doctor.dart';
import 'package:patient_app/Patient.dart';
import 'package:patient_app/Pharmacie.dart';
import 'package:patient_app/Analyse.dart';
import 'package:patient_app/X-ray.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      title: "Lottie Animation",
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blueAccent,
            Colors.lightBlueAccent,
          ],
        )),
        child: new Column(
          children: [
            new Container(
              margin: new EdgeInsets.symmetric(vertical: 25.0),
              child: Text(
                "Welcome To HOSPY",
                textAlign: TextAlign.justify,
                style: TextStyle(
                fontFamily: 'Aleo',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                    color: Colors.white
                ),
              ),
            ),
            new Container(
              child: Lottie.asset(
                'assets/doctor-welcoming-patient.json',
                width: MediaQuery.of(context).size.width,
                height: 140,
              ),
            ),
            new Container(
              child: new Column(
                children: [
                  new Container(
                    margin: new EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      "You Are",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontFamily: 'Aleo',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          color: Colors.white

                      ),
                    ),
                  ),
                  new Container(
                    child: ElevatedButton(
                      child: Text(
                        'Doctor',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Aleo',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => new Doctor()));
                      },
                    ),
                  ),
                  new Container(
                    child: ElevatedButton(
                      child: Text(
                        'Patient',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Aleo',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => new Patient()));
                      },
                    ),
                  ),
                  new Container(
                    child: ElevatedButton(
                      child: Text(
                        'Analyser',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Aleo',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => new Analyse()));
                      },
                    ),
                  ),
                  new Container(
                    child: ElevatedButton(
                      child: Text(
                        'X-Ray Taker',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Aleo',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => new Xray()));
                      },
                    ),
                  ),
                  new Container(
                    child: ElevatedButton(
                      child: Text(
                        'Pharmasist',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Aleo',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => new Pharmacie()));
                      },
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

