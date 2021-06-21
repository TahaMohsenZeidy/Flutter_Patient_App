import 'package:patient_app/Doctor/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:patient_app/Doctor/screens/all_history.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/material.dart';
import 'package:patient_app/Doctor/new_consultation.dart';

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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => new NewConsultation()));
          },
          label: Text("New Consultation"),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex:5,
                  child:Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    ),
                    child: Column(
                        children: [
                          SizedBox(height: 110.0,),
                          CircleAvatar(
                            radius: 65.0,
                            backgroundImage: AssetImage('assets/as.png'),
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(height: 10.0,),
                          Text('Erza Scarlet',
                              style: TextStyle(
                                color:Colors.white,
                                fontSize: 20.0,
                              )),
                          SizedBox(height: 10.0,),
                          Text('S Class Mage',
                            style: TextStyle(
                              color:Colors.white,
                              fontSize: 15.0,
                            ),)
                        ]
                    ),
                  ),
                ),

                Expanded(
                  flex:5,
                  child: Container(
                    color: Colors.grey[200],
                    child: Center(
                        child:Card(
                            margin: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                            child: Container(
                                width: 310.0,
                                height:290.0,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Information",
                                        style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w800,
                                        ),),
                                      Divider(color: Colors.grey[300],),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.home,
                                            color: Colors.blueAccent,
                                            size: 35,
                                          ),
                                          SizedBox(width: 20.0,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ElevatedButton(
                                                child: Text(
                                                  'Patients History',
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
                                                          builder: (BuildContext context) => new PatientsScreen()));
                                                },
                                              ),
                                              // Text("",
                                              //   style: TextStyle(
                                              //     fontSize: 15.0,
                                              //   ),),
                                            ],
                                          )

                                        ],
                                      ),
                                      SizedBox(height: 20.0,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.auto_awesome,
                                            color: Colors.blueAccent,
                                            size: 35,
                                          ),
                                          SizedBox(width: 20.0,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ElevatedButton(
                                                child: Text(
                                                  'Medical Tests    ',
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
                                                          builder: (BuildContext context) => new PatientsScreen()));
                                                },
                                              ),
                                            ],
                                          )

                                        ],
                                      ),
                                    ],
                                  ),
                                )
                            )
                        )
                    ),
                  ),
                ),

              ],
            ),
            Positioned(
                top:MediaQuery.of(context).size.height*0.45,
                left: 20.0,
                right: 20.0,
                child: Card(
                    child: Padding(
                      padding:EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              child:Column(
                                children: [
                                  Text('Gender',
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 14.0
                                    ),),
                                  SizedBox(height: 5.0,),
                                  Text("Male",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),)
                                ],
                              )
                          ),

                          Container(
                            child: Column(
                                children: [
                                  Text('Birthday',
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 14.0
                                    ),),
                                  SizedBox(height: 5.0,),
                                  Text('April 7th',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),)
                                ]),
                          ),

                          Container(
                              child:Column(
                                children: [
                                  Text('Age',
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 14.0
                                    ),),
                                  SizedBox(height: 5.0,),
                                  Text('19 yrs',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),)
                                ],
                              )
                          ),
                        ],
                      ),
                    )
                )
            )
          ],

        ),
      );
    }
  }

//its quite simple as that you can use try and catch staatements too for platform exception
}
