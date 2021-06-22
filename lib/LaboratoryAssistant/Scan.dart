import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:patient_app/LaboratoryAssistant/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/material.dart';
import '../main.dart';
import '../sizeConfig.dart';
import 'UploadFile.dart';
import 'Buttom_widget.dart';

class ScanPage extends StatefulWidget with NavigationStates {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String tests;
  UploadTask task;
  File file;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file);
    setState(() {});

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );

  String qrCodeResult = "Not Yet Scanned";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
      return FutureBuilder<DocumentSnapshot>(
          future: medTestRef.doc(qrCodeResult).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data1 = snapshot.data.data();
              final fileName =
                  file != null ? basename(file.path) : 'No File Selected';
              return FutureBuilder<DocumentSnapshot>(
                  future: patientsRef.doc(qrCodeResult).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.hasData && !snapshot.data.exists) {
                      return Text("Document does not exist");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data.data();

                      return Scaffold(
                        body: Stack(
                          children: [
                            Column(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                    ),
                                    child: Column(children: [
                                      SizedBox(
                                        height: 110.0,
                                      ),
                                      CircleAvatar(
                                        radius: 65.0,
                                        backgroundImage:
                                            AssetImage('assets/as.png'),
                                        backgroundColor: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        '${data['username']}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                        ),
                                      )
                                    ]),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    color: Colors.grey[200],
                                    child: Center(
                                        child: Card(
                                            margin: EdgeInsets.fromLTRB(
                                                0.0, 45.0, 0.0, 0.0),
                                            child: Container(
                                                width: 310.0,
                                                height: 290.0,
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Information",
                                                        style: TextStyle(
                                                          fontSize: 17.0,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                        ),
                                                      ),
                                                      Divider(
                                                        color: Colors.grey[300],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.article_sharp,
                                                            color: Colors
                                                                .blueAccent,
                                                            size: 35,
                                                          ),
                                                          SizedBox(
                                                            width: 20.0,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Medical tests requested :",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                ),
                                                              ),
                                                              Text(
                                                                "${data1['medTest']}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      12.0,
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 20.0,
                                                      ),
                                                      Column(
                                                        children: <Widget>[
                                                          ButtonWidget(
                                                            text: 'Select File',
                                                            icon: Icons
                                                                .attach_file,
                                                            onClicked:
                                                                selectFile,
                                                          ),
                                                          SizedBox(height: 8),
                                                          Text(
                                                            fileName,
                                                            style: TextStyle(
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          SizedBox(height: 15),
                                                          ButtonWidget(
                                                            text: 'Upload File',
                                                            icon: Icons
                                                                .cloud_upload_outlined,
                                                            onClicked:
                                                                uploadFile,
                                                          ),
                                                          SizedBox(height: 20),
                                                          task != null
                                                              ? buildUploadStatus(
                                                                  task)
                                                              : Container(),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )))),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                                top: MediaQuery.of(context).size.height * 0.45,
                                left: 20.0,
                                right: 20.0,
                                child: Card(
                                    child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                          child: Column(
                                        children: [
                                          Text(
                                            'cin',
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontSize: 14.0),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "${data['cin']}",
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          )
                                        ],
                                      )),
                                      Container(
                                        child: Column(children: [
                                          Text(
                                            'phone',
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontSize: 14.0),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            '${data['phone']}',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          )
                                        ]),
                                      ),
                                      Container(
                                          child: Column(
                                        children: [
                                          Text(
                                            'Age',
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontSize: 14.0),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            '${data['age']}yrs',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          )
                                        ],
                                      )),
                                    ],
                                  ),
                                )))
                          ],
                        ),
                      );
                    }
                    return FutureBuilder<DocumentSnapshot>(
                        future: medTestRef.doc(qrCodeResult).get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }

                          if (snapshot.hasData && !snapshot.data.exists) {
                            return Text("Document does not exist");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data1 = snapshot.data.data();
                            tests = tests + data1['medTest'];

                            return Scaffold(
                                body: Stack(
                              children: [
                                Column(children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 110.0,
                                          ),
                                          Text(
                                            'medical  tests requested ',
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontSize: 14.0),
                                          ),
                                          SizedBox(
                                            height: 18.0,
                                          ),
                                          Text(
                                            '${data1['medTest']}',
                                            style: TextStyle(
                                              fontSize: 26.0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              ],
                            ));
                          }
                        });
                  });

//its quite simple as that you can use try and catch staatements too for platform exception
            }
          });
    }
    ;
  }
}
