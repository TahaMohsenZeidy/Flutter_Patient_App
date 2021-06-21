import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import 'bottomAnimation.dart';

final controllerMedImage = TextEditingController();
final controllerMedTest = TextEditingController();
final controllerDisName = TextEditingController();
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
      controllerDisName.clear();
      controllerDesc.clear();
    }

    addingDisease() {

      var id = "XghHOeNbye34gG11yG9n";
      print("rani lenna");

      // diseasesRef.add({
      //   'doctor_id': _auth.currentUser.uid,
      //   'patient_id': "l patient li bech tescanih",
      //   'disease_name': controllerDisName.text,
      //   'disease_desc': controllerDesc.text,
      //   'MedImage': controllerMedImage.text,
      //   'MedTest': controllerMedTest.text,
      // });
      controllerClear();
      // Toast.show('Added Successfully!', context,
      //     backgroundRadius: 5, backgroundColor: Colors.blue, duration: 3);
      Fluttertoast.showToast(
          msg: 'Added Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.red
      );
      Navigator.pop(context);
    }

    final addBtn = Container(
        width: double.infinity,
        height: 50,
        child: RaisedButton(
          onPressed: () {
            setState(() {
              controllerMedImage.text.isEmpty
                  ? validMedImage = true
                  : validMedImage = false;
              controllerMedTest.text.isEmpty
                  ? validMedTest = true
                  : validMedTest = false;
            });
            !validDisName &
                    !validDesc &
                    !validMedTest &
                    !validMedImage
                ? addingDisease()
                : Fluttertoast.showToast(
                msg: 'Profile Updated Successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.green,
                textColor: Colors.red
            );
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
