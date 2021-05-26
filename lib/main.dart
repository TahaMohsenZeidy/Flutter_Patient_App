import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:patient_app/screens/login_screen.dart';
import 'package:patient_app/screens/login_screen_patient.dart';
import 'Scan_generate_QR/Generate.dart';
import 'Scan_generate_QR/Scan.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

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
        child: SingleChildScrollView(
          child: new Column(
            children: [
              new Container(
                margin: new EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 12),
                child: GradientText(
                  text:"HOSPY",
                  colors: <Color>[
                    Colors.cyanAccent,
                    Colors.white60,
                    Colors.cyanAccent,
                  ],
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                  fontFamily: 'Aleo',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0,
                  ),
                ),
              ),
              new Container(
                child: Lottie.asset(
                  'assets/doctor-welcoming-patient.json',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2.8,
                ),
              ),
              new Container(
                child: new Column(
                  children: [
                    new Container(
                      child: ElevatedButton(
                        child: Text(
                          'Doctor',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Aleo',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => new LoginScreen()));
                          // LoginScreen
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
                              fontSize: 18.0,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => new LoginScreenPatient()));
                        },
                      ),
                    ),
                    new Container(
                      child: ElevatedButton(
                        child: Text(
                          'Tester',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Aleo',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => new ScanPage()));
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
                              fontSize: 18.0,
                              color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => new GeneratePage()));
                        },
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              ),
              Text("All Rights Reserved ENIS 2021/2022",
              style: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: 10,
                letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

