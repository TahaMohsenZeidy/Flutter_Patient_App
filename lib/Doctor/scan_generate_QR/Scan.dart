import 'package:patient_app/Patient/DocInfoPage.dart';
import 'package:patient_app/Doctor/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/material.dart';
import 'package:patient_app/Patient/colorScheme.dart';

class ScanPage extends StatefulWidget with NavigationStates {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String qrCodeResult = "Not Yet Scanned";
  @override
  Widget build(BuildContext context) {
    if (qrCodeResult == "Not Yet Scanned") {
      return Scaffold(
        appBar: AppBar(
          title: Text("Scanner"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Result",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                qrCodeResult,
                style: TextStyle(
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20.0,
              ),
              FlatButton(
                padding: EdgeInsets.all(15.0),
                onPressed: () async {
                  String codeSanner = await scanner.scan(); //barcode scanner
                  setState(() {
                    qrCodeResult = codeSanner;
                  });

                  // try{
                  //   BarcodeScanner.scan()    this method is used to scan the QR code
                  // }catch (e){
                  //   BarcodeScanner.CameraAccessDenied;   we can print that user has denied for the permisions
                  //   BarcodeScanner.UserCanceled;   we can print on the page that user has cancelled
                  // }
                },
                child: Text(
                  "Open Scanner",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue, width: 3.0),
                    borderRadius: BorderRadius.circular(20.0)),
              )
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [getStartedColorStart, getStartedColorEnd],
            begin: Alignment(0, -1.15),
            end: Alignment(0, 0.4),
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 1,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                  color: bgColor,
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              height: 120,
                              width: 120,
                              child: ClipOval(
                                child: Image(
                                  height: 20.0,
                                  width: 20.0,
                                  image: AssetImage('assets/user_icon.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Sonia rbii",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  width: 50,
                                ),
                                Text(
                                  "Id :" + qrCodeResult,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 12, right: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Age :",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "68 ans  ",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Medecine  requested:",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Panadol Extra ",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Physiol ",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Doctor responsible",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                ),
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DocInfoPage(),
                                    ),
                                  ),
                                },
                                child: Text('Dr Maryem Hamdeni'),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: 150,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

//its quite simple as that you can use try and catch staatements too for platform exception
}
