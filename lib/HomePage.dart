import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:patient_app/Patient/sidebar/sidebar_layout.dart';
import 'Doctor/sidebar/sidebar_layout.dart';
import 'LaboratoryAssistant/sidebar/sidebar_layout.dart';
import 'Pharmacie/Scan_generate_QR/Scan.dart';
import 'Radiologist/sidebar/sidebar_layout.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
    this.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: !isloggedin
          ? CircularProgressIndicator()
          : Column(
              children: <Widget>[
                SizedBox(height: 40.0),
                Container(
                  height: 300,
                  child: Image(
                    image: AssetImage("assets/login.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  child: Text(
                    "Hello ${user.displayName} you are Logged in as ${user.email}",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                  onPressed: signOut,
                  child: Text('Signout',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                  onPressed: () => {

                    if (user.displayName == "Doctor")
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                // builder: (BuildContext context) => new EditProfile()))
                                builder: (BuildContext context) =>
                                    new SideBarLayoutDoctor()))
                      }

                    else if (user.displayName == "Patient")
                      {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              // builder: (BuildContext context) => new EditProfile()))
                                builder: (BuildContext context) =>
                                new SideBarLayoutPatient()))
                      }

                    else if (user.displayName == "Lab Assistant")
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                // builder: (BuildContext context) => new EditProfile()))
                                  builder: (BuildContext context) =>
                                  new SideBarLayoutLaboratoryAssistant()))
                        }

                      else if (user.displayName == "Radiologist")
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  // builder: (BuildContext context) => new EditProfile()))
                                    builder: (BuildContext context) =>
                                    new SideBarLayoutRadiologist()))
                          }
                        else if (user.displayName == "Radiologist")
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    // builder: (BuildContext context) => new EditProfile()))
                                      builder: (BuildContext context) =>
                                      new ScanPage()))
                            }

                  },
                  child: Text('Continue',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                  color: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                )
              ],
            ),
    ));
  }
}
