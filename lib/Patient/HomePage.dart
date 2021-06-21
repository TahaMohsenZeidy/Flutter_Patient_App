import 'package:patient_app/Patient/DocInfoPage.dart';
import 'package:patient_app/Patient/colorScheme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:patient_app/data/data.dart';
import 'package:patient_app/main.dart';

// ignore: camel_case_types
class Patient_Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'avenir',
      ),
      home: MyFirstPage(),
      routes: {
        '/DocInfoPage': (context) => DocInfoPage(),
      },
    );
  }
}

class MyFirstPage extends StatefulWidget {
  @override
  _MyFirstPageState createState() => _MyFirstPageState();
}

class _MyFirstPageState extends State<MyFirstPage> {
  List<Widget> docs = [];
  List<Widget> _tmpDocs = [];
  List<String> specialities = [];
  var t = "All doctors";
  @override
  void initState() {
    super.initState();
    fetchDoctorsInfos();
  }

  fetchDoctorsInfos() async {
    var snapQuery = await docsRef.get();
    snapQuery.docs.forEach((d) {
      _tmpDocs.add(createDocWidget(d["imgUrl"],
          "${d['firstName']} ${d['lastName']}", d.id, d["shortDescription"]));
      specialities.add(d["speciality"]);
    });

    setState(() {
      docs = _tmpDocs;
    });
  }

  sortBySpecialty(String speciality) {
    List<Widget> tmp = [];
    if (speciality == "All Doctors") {
      tmp = _tmpDocs;
    } else {
      for (int i = 0; i < specialities.length; i++) {
        if (specialities[i] == speciality) {
          tmp.add(_tmpDocs[i]);
        }
      }
    }
    setState(() {
      docs = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CustomPaint(
              painter: pathPainter(),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: <Widget>[
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [
                            getStartedColorStart,
                            getStartedColorEnd
                          ], stops: [
                            0,
                            1
                          ])),
                      child: Center(
                        child: Text(
                          "User",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14, right: 10, top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Find Doctor or Category",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        margin: EdgeInsets.only(top: 10),
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            categoryContainer(
                                "assets/allCat.png", "All Doctors"),
                            categoryContainer(
                                "assets/category7.png", "CT-Scan"),
                            categoryContainer("assets/category1.png", "Ortho"),
                            categoryContainer(
                                "assets/category2.png", "Dietician"),
                            categoryContainer(
                                "assets/category3.png", "Physician"),
                            categoryContainer(
                                "assets/category4.png", "Paralysis"),
                            categoryContainer(
                                "assets/category5.png", "Cardiology"),
                            categoryContainer(
                                "assets/category6.png", "MRI - Scan"),
                            categoryContainer(
                                "assets/category8.png", "Gynaecology"),
                          ],
                        ),
                      ),
                      Text(
                        "Chief Doctors",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 300,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: <Widget>[
                              ...docs,
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  categoryContainer(String imgName, String title) {
    return GestureDetector(
        child: Container(
          width: 130,
          child: Column(
            children: <Widget>[
              Text(
                "$title",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
              ),
              Image.asset(imgName),
            ],
          ),
        ),
        // When the child is tapped, show a snackbar.
        onTap: () {
          sortBySpecialty(title);
        });
  }

  Container createDocWidget(
      String imgName, String docName, String docId, String shortDescription) {
    return Container(
      child: InkWell(
        child: Container(
          margin: EdgeInsets.only(bottom: 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: docContentBgColor,
          ),
          child: Container(
            padding: EdgeInsets.all(6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(3),
                  height: 65,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(imgName), fit: BoxFit.fill),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Dr. $docName",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 250,
                      height: 50,
                      child: Text(
                        "$shortDescription",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => docInfoPage(
                docId: docId,
              ),
            ),
          );
        },
      ),
    );
  }

  void openDocInfo() {
    Navigator.pushNamed(context, '/DocInfoPage');
  }
}

class pathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint.color = path2Color;

    Path path = new Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.3, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.03,
        size.width * 0.42, size.height * 0.17);
    path.quadraticBezierTo(
        size.width * 0.35, size.height * 0.32, 0, size.height * 0.29);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
