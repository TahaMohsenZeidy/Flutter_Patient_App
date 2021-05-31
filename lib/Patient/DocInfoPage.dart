import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:patient_app/Patient/clientAppointment.dart';
import 'package:patient_app/colorScheme.dart';
import 'package:flutter/material.dart';
import 'package:patient_app/data/data.dart';

class DocInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'avenir',
      ),
      home: docInfoPage(),
    );
  }
}

class docInfoPage extends StatefulWidget {
  final String docId;

  const docInfoPage({Key key, this.docId}) : super(key: key);
  @override
  _docInfoPageState createState() => _docInfoPageState();
}

class _docInfoPageState extends State<docInfoPage> {
  List<Data> datalist = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPageData();
  }

  Data dat;
  fetchPageData() async {
    var refeferenceData = FirebaseFirestore.instance.collection("doctors");
    var data = await refeferenceData.doc(widget.docId).get();
    datalist.clear();
    dat = new Data(
      data["imgUrl"],
      data["firstName"],
      data["lastName"],
      data["speciality"],
      data["hospital"],
      data["shortDescription"],
      data["longDescription"],
      data["availableTime"],
    );

    setState(() {
      datalist.add(dat);
    });
  }

  buildPageImage(String spec) {
    switch (spec) {
      case "Heart Surgeon":
        {
          return Image.asset('assets/images/docinfo/bg1.png');
        }
        break;
      case "CT-Scan":
        {
          return Image.asset('assets/images/docinfo/bg2.png');
        }
        break;

      case "Ortho":
        {
          return Image.asset('assets/images/docinfo/bg3.png');
        }
        break;

      case "Dietician":
        {
          return Image.asset('assets/images/docinfo/bg4.png');
        }
        break;

      case "Physician":
        {
          return Image.asset('assets/images/docinfo/bg5.png');
        }
        break;

      case "Paralysis":
        {
          return Image.asset('assets/images/docinfo/bg7.png');
        }
        break;

      case "MRI - Scan":
        {
          return Image.asset('assets/images/docinfo/bg2.png');
        }
        break;

      case "Gynaecology":
        {
          return Image.asset('assets/images/docinfo/bg6.png');
        }
        break;

      default:
        {
          return Text("");
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: datalist.length == 0
            ? Center(
                child: Text(
                "No Data Available",
                style: TextStyle(fontSize: 30),
              ))
            : Container(
                child: CardUI(
                dat.imgUrl,
                dat.firstName,
                dat.lastName,
                dat.speciality,
                dat.hospital,
                dat.shortDesc,
                dat.longDesc,
                dat.availableTime.toString(),
              )));
  }

  Widget CardUI(
      String imgUrl,
      String firstName,
      String lastName,
      String speciality,
      String hospital,
      String shortDesc,
      String longDesc,
      String availableTime) {
    print("spectialty = $speciality");
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [getStartedColorStart, getStartedColorEnd],
        begin: Alignment(0, -1.15),
        end: Alignment(0, 0.1),
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.all(20),
              child: buildPageImage(speciality),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: bgColor,
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(imgUrl), fit: BoxFit.fill),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Dr. $firstName $lastName",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "$speciality - $hospital",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "About the Doctor",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "$longDesc",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Available Time Slots",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          timeSlotWidget("13", "MAY", "Consultation",
                              "Sunday 9 am to 11.30 am"),
                          timeSlotWidget("14", "MAY", "Consultation",
                              "Monday 10 am to 12.30 am"),
                          timeSlotWidget("1", "JUN", "Consultation",
                              "Wednesday 8 am to 12.30 pm"),
                          timeSlotWidget("3", "JUN", "Consultation",
                              "Friday 8 am to 1 am"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container timeSlotWidget(
      String date, String month, String slotType, String time) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: docContentBgColor),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Container(
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: dateBgColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "$date",
                    style: TextStyle(
                        color: dateColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "$month",
                    style: TextStyle(
                        color: dateColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "$slotType",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  "$time",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
