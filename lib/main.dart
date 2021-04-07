import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:patient_app/Pharmacie.dart';
import 'package:patient_app/Scan_generate_QR/Generate.dart';
import 'package:patient_app/Doctor_Package/oldLogin.dart';
import 'package:patient_app/loginNew.dart';


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
                height: MediaQuery.of(context).size.height / 4.0,
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
                                builder: (BuildContext context) => new LoginNew()));
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
                                builder: (BuildContext context) => new GeneratePage()));
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
                                builder: (BuildContext context) => new LoginDoctor()));
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
                                builder: (BuildContext context) => new Pharmacie()));
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
    );
  }
}

