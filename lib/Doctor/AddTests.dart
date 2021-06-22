import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patient_app/Doctor/scan_generate_QR/Scan.dart';

import 'bottomAnimation.dart';

final controllerMedImage = TextEditingController();
final controllerMedTest = TextEditingController();

final controllerDesc = TextEditingController();
FirebaseAuth _auth = FirebaseAuth.instance;

class AddDisease extends StatefulWidget {
  @override
  _AddDiseaseState createState() => _AddDiseaseState();
}

class _AddDiseaseState extends State<AddDisease> {
  bool validDisName = false;
  bool validDesc = false;
  bool validMedImage = false;
  bool validMedTest = false;
  User user = FirebaseAuth.instance.currentUser;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Future instantNofitication() async {
    var android = AndroidNotificationDetails("id", "channel", "description");

    var ios = IOSNotificationDetails();

    var platform = new NotificationDetails(android: android, iOS: ios);

    await flutterLocalNotificationsPlugin.show(
        0, "your doctor has added new tests", "Tap to see tests", platform,
        payload: "");
  }

  get id => user.uid;

  addingDisease() {
    FirebaseFirestore.instance
        .collection('medical tests')
        .doc(ScanPage.qrCodeResult)
        .set({
      'Desc': controllerDesc.text,
      'medTest': controllerMedTest.text,
      'medImage': controllerMedImage.text,
      'IdDoctor': id,
      'IdPatient': ScanPage.qrCodeResult,
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final medDescTF = TextField(
      keyboardType: TextInputType.multiline,
      autofocus: false,
      controller: controllerDesc,
      maxLines: null,
      decoration: InputDecoration(
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: WidgetAnimator(
              Image(
                image: AssetImage('assets/medkit.png'),
                height: height * 0.04,
              ),
            ),
          ),
          labelText: 'Description',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    // ignore: non_constant_identifier_names
    final MedImage = TextField(
      keyboardType: TextInputType.multiline,
      autofocus: false,
      controller: controllerMedImage,
      maxLines: null,
      decoration: InputDecoration(
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: WidgetAnimator(
              Image(
                image: AssetImage('assets/patient.png'),
                height: height * 0.04,
              ),
            ),
          ),
          labelText: 'Image medical',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    // ignore: non_constant_identifier_names
    final MedTest = TextField(
      keyboardType: TextInputType.multiline,
      autofocus: false,
      controller: controllerMedTest,
      maxLines: null,
      decoration: InputDecoration(
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: WidgetAnimator(
              Image(
                image: AssetImage('assets/steth.png'),
                height: height * 0.04,
              ),
            ),
          ),
          labelText: 'Medical analyses',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    controllerClear() {
      controllerMedImage.clear();
      controllerMedTest.clear();

      controllerDesc.clear();

      controllerClear();

      Fluttertoast.showToast(
          msg: '  Edded successfully ',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.yellow);
      Navigator.pop(context);
    }

    final addBtn = Container(
        width: double.infinity,
        height: 50,
        child: RaisedButton(
          onPressed: () {
            instantNofitication();
            addingDisease();
            setState(() {
              controllerDesc.text.isEmpty
                  ? validDesc = true
                  : validDesc = false;
              controllerMedImage.text.isEmpty
                  ? validMedImage = true
                  : validMedImage = false;
              controllerMedTest.text.isEmpty
                  ? validMedTest = true
                  : validMedTest = false;
            });

            !validDesc & !validMedTest & !validMedImage
                ? addingDisease()
                : Fluttertoast.showToast(
                    msg: '  Empty filed ',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.yellow);
          },
          color: Colors.blueAccent,
          shape: StadiumBorder(),
          child: Text(
            'Add',
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
        ));

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Adding Medical Test"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: width,
              margin: EdgeInsets.fromLTRB(width * 0.025, 0, width * 0.025, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: height * 0.12,
                  ),
                  Text(
                    'Enter the Following Information',
                    style: GoogleFonts.abel(fontSize: height * 0.025),
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  medDescTF,
                  SizedBox(
                    height: height * 0.02,
                  ),
                  MedTest,
                  SizedBox(
                    height: height * 0.02,
                  ),
                  MedImage,
                  SizedBox(
                    height: height * 0.02,
                  ),
                  addBtn,
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
