import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/LaboratoryAssistant/sidebar/sidebar.dart';
import 'package:patient_app/Radiologist/sidebar/sidebar.dart';
import 'package:patient_app/Radiologist/bloc.navigation_bloc/navigation_bloc.dart';

import 'package:patient_app/Doctor/widgets/profile_clipper.dart';

import '../main.dart';

class ProfilePage extends StatefulWidget with NavigationStates {
  final User user;
  ProfilePage({this.user});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _yourPostsPageController;
  PageController _favoritesPageController;
  var _name = "....";
  var _specaility = "....";
  var _experience = "....";
  var _email;

  @override
  void initState() {
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    var currentDoc = radiologistsRef.doc(user.uid).get();
    if (currentDoc == null) {
      print("it is a new doctor");
    } else {
      print(currentDoc.toString());
    }
    _email = user.email;
    currentUser = user;
    _yourPostsPageController =
        PageController(initialPage: 0, viewportFraction: 0.8);
    _favoritesPageController =
        PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: radiologistsRef.doc(currentUser.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            return Scaffold(
              key: _scaffoldKey,
              drawer: SideBar(),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        ClipPath(
                          clipper: ProfileClipper(),
                          child: Image(
                            height: 300.0,
                            width: double.infinity,
                            image: AssetImage('assets/doctors.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 10.0,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  offset: Offset(0, 2),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image(
                                height: 120.0,
                                width: 120.0,
                                image: AssetImage('assets/user0.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Welcome radiologist",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'Name',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 22.0,
                              ),
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              "${data['username']}",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'phone',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 22.0,
                              ),
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              "${data['phone']}",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              'E - mail',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 22.0,
                              ),
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              "${data['email']}",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'Experience',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 22.0,
                              ),
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              "${data['experience']}" + "years",
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
            );
          }
        });
  }
}
