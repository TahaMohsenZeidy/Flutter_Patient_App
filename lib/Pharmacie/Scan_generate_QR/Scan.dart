import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/material.dart';

import '../../main.dart';

class ScanPage extends StatefulWidget {
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
      return FutureBuilder<DocumentSnapshot>(
          future: medicineRef.doc(qrCodeResult).get(),
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
                                      Text('${data['username']}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          )),
                                      SizedBox(
                                        height: 10.0,
                                      ),
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
                                                        "prescription:",
                                                        style: TextStyle(
                                                          fontSize: 23.0,
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
                                                            Icons.apps_rounded,
                                                            color: Colors
                                                                .blueAccent,
                                                            size: 35,
                                                          ),
                                                          SizedBox(
                                                            width: 12.0,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Medecine name :",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5.0,
                                                              ),
                                                              Text(
                                                                "-" +
                                                                    " ${data1['medName']}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.apps_rounded,
                                                            color: Colors
                                                                .blueAccent,
                                                            size: 35,
                                                          ),
                                                          SizedBox(
                                                            width: 17.0,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Medecine type :",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5.0,
                                                              ),
                                                              Text(
                                                                "-" +
                                                                    " ${data1['medType']}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.apps_rounded,
                                                            color: Colors
                                                                .blueAccent,
                                                            size: 35,
                                                          ),
                                                          SizedBox(
                                                            width: 17.0,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Medecine duration: ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5.0,
                                                              ),
                                                              Text(
                                                                "-" +
                                                                    " ${data1['interval']}" +
                                                                    "jours",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Icon(
                                                            Icons.apps_rounded,
                                                            color: Colors
                                                                .blueAccent,
                                                            size: 35,
                                                          ),
                                                          SizedBox(
                                                            width: 17.0,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "Medecine time ",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10.0,
                                                              ),
                                                              Text(
                                                                "-" +
                                                                    " ${data1['medTime']}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 20.0,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 20.0,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [],
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 20.0,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 20.0,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [],
                                                          )
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
                                            '${data['cin']}',
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
                                            '${data['age']}',
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
                  });

//its quite simple as that you can use try and catch staatements too for platform exception
            }
          });
    }
  }
}
