import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:patient_app/Doctor/bloc.navigation_bloc/navigation_bloc.dart';
import 'dart:math';
import 'package:patient_app/Doctor/screens/appointmentDetailScreen/AppointmentDetailScreen.dart';
import 'package:patient_app/Doctor/sidebar/sidebar.dart';
import 'package:patient_app/Doctor/widgets/appointmentWidgetComponents/AppointmentCard.dart';
import 'package:patient_app/Doctor/widgets/appointmentWidgetComponents/MiniAppointmentCard.dart';
import 'package:patient_app/Doctor/widgets/appointmentWidgetComponents/SlidingCard.dart';
import 'package:patient_app/main.dart';
import 'package:patient_app/models/appointmentModels/Appointment.dart';
import '../../../sizeConfig.dart';

class AppointmentScreen extends StatefulWidget with NavigationStates {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  bool isFirstTime = false;
  bool isLoading = true;
  List<Widget> topHeader;
  List<Widget> currentAppointment;
  List<Widget> midHeader;
  List<Widget> futureAppointment;
  List<Widget> finalList;
  SlidingCardController aController = new SlidingCardController();
  List<Widget> pastAppointments = [];
  List<Widget> futureAppointments = [];
  @override
  void initState() {
    super.initState();
    topHeader = [];
    currentAppointment = [];
    midHeader = [];
    futureAppointment = [];
    finalList = [];
    fetchData();
  }

  fetchCloudData() async {
    List<Appointment> l = [];
    var docs = await FirebaseFirestore.instance.collection('Appointments').get();
    docs.docs.forEach((element) {
      l.add(Appointment.getAppointmentFromDoc(element));
      print("added Doc !");
    });
    return l;
  }

  fetchData() async {
    List<Appointment> apps = await fetchCloudData();

    futureAppointment=[];
    pastAppointments = [];
    setState(() {
      apps.forEach((a) {
        if(a.isFuture){
          futureAppointment.add(AppointmentCard(
            onCardTapped: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: AppointmentDetailScreen(
                        appointmentData: a,
                      )));
            },
            key: Key(Random().nextInt(4000).toString()),
            slidingCardController: aController,
            appointmentData: a,
          ),);
        }else{
          pastAppointments.add(MiniAppointmentCard(
              onCardTapped: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: AppointmentDetailScreen(
                          appointmentData: a,
                        )));
              },
              appointmentData:a)
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (isFirstTime == false) {
      initiateList();
      isFirstTime = true;
    }
<<<<<<< Updated upstream
    // var ids = AppointmentManager.getAllAppointmentIDs();
    // print("tawa bech yebda jaw");
    // ids.forEach((element){
    //   print(element);
    // });
    return FutureBuilder<DocumentSnapshot>(
      future: appointementsRef.doc("Kj84RycRkrldJRXrP1Z2").get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
=======
    return Scaffold(
      body: Column(
        children: [
          buildHeader(),
          buildDocName(),
          ...pastAppointments,
          buildFooter(),
          ...futureAppointment,
        ],
      ),
    );

  }
>>>>>>> Stashed changes

  buildHeader(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 7, top: 100),
      child: new Container(
        width: SizeConfig.safeBlockHorizontal * 90,
        height: SizeConfig.verticalBloc * 8,
        //color: Colors.pink,
        child: Row(
          children : [
            Text('Bienvenue !',
              style: TextStyle(
                  fontSize: SizeConfig.horizontalBloc * 7, color: Colors.black45),),
            TextButton.icon(onPressed: fetchData, icon: Icon(Icons.refresh), label: Text("")),
          ]

<<<<<<< Updated upstream
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          // return Text("Full Name: ${data['full name']} ${data['Gender']}");
          return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              backgroundColor: Color(0xffF3F6FF).withOpacity(0.134),
              elevation: 0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.sync,
                    color: Colors.black54,
                    size: SizeConfig.horizontalBloc * 8,
                  ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    topHeader..clear();
                    currentAppointment..clear();
                    midHeader..clear();
                    futureAppointment.clear();
                    finalList..clear();
                    AppointmentManager.appointmentList.clear();
                    AppointmentManager.generateAppointmentList(data);
                    initiateList();
                    Future.delayed(Duration(milliseconds: 375), () {
                      isLoading = false;
                      setState(() {});
                    });
                  },
                )
              ],
            ),
            drawer: SideBar(),
            body: isLoading
                ? SizedBox()
                : Container(
                    color: Color(0xffF3F6FF).withOpacity(0.134),
                    child: AnimationLimiter(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: finalList.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (isFirstTime == false) {
                            setState(() {});
                          }

                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: -20,
                              child: FadeInAnimation(child: finalList[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          );
        }
        return Text("loading");
      },
=======
        ),
      ),
    );
  }

  buildDocName(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 7),
      child: new Container(
        width: SizeConfig.safeBlockHorizontal * 90,
        height: SizeConfig.verticalBloc * 8,
        //color: Colors.pink,
        child: Text(
          'Dr. CurrentDoc',
          style: TextStyle(
            fontSize: SizeConfig.horizontalBloc * 9.5,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  buildFooter(){
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 9, left: 20),
      child: Container(
        width: SizeConfig.safeBlockHorizontal * 90,
        height: SizeConfig.verticalBloc * 3,
        //color: Colors.pink,
        child: Text(
          'Next appointments',
          style: TextStyle(
              fontSize: SizeConfig.horizontalBloc * 5, color: Colors.black45),
        ),
      ),
>>>>>>> Stashed changes
    );
  }

  Future<bool> initiateList() async {
    //First we work on the header of the list
    topHeader.add(Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 7, top: 7),
      child: new Container(
        width: SizeConfig.safeBlockHorizontal * 90,
        height: SizeConfig.verticalBloc * 8,
        //color: Colors.pink,
        child: Text(
          'Bienvenue !',
          style: TextStyle(
              fontSize: SizeConfig.horizontalBloc * 7, color: Colors.black45),
        ),
      ),
    ),

    );
    topHeader.add(
      Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 7),
        child: new Container(
          width: SizeConfig.safeBlockHorizontal * 90,
          height: SizeConfig.verticalBloc * 8,
          //color: Colors.pink,
          child: Text(
            'Dr. CurrentDoc',
            style: TextStyle(
              fontSize: SizeConfig.horizontalBloc * 9.5,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );

    //now we create the card comming from the appointment manager
    for (var anElement in AppointmentManager.appointmentList) {

    print(anElement.patientName);
      if (anElement.isFuture == false) {
        SlidingCardController aController = new SlidingCardController();
        print('adding big card');
        currentAppointment.add(Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AppointmentCard(
            onCardTapped: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: AppointmentDetailScreen(
                        appointmentData: anElement,
                      )));
            },
            key: Key(Random().nextInt(4000).toString()),
            slidingCardController: aController,
            appointmentData: anElement,
          ),
        )));
      } else {
        print('adding mini card');
        futureAppointment.add(Center(
            child: MiniAppointmentCard(
          onCardTapped: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: AppointmentDetailScreen(
                      appointmentData: anElement,
                    )));
          },
          appointmentData: anElement,
        )));
      }
    }
    midHeader.add(
      Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 9, left: 20),
        child: Container(
          width: SizeConfig.safeBlockHorizontal * 90,
          height: SizeConfig.verticalBloc * 3,
          //color: Colors.pink,
          child: Text(
            'Next appointments',
            style: TextStyle(
                fontSize: SizeConfig.horizontalBloc * 5, color: Colors.black45),
          ),
        ),
      ),
    );

    // We create the final list that will be passed to the
    //listView.builder
    finalList.addAll(topHeader);
    finalList.addAll(currentAppointment);
    finalList.addAll(midHeader);
    finalList.addAll(futureAppointment);
    if (isFirstTime == false) {
      isLoading = false;
      setState(() {});
    }
    setState(() {});
    return true;
  }
}

class AppointmentManager {
  static List<Appointment> appointmentList = [];
  static List generateAppointmentList(Map<String, dynamic> data) {
    String img = "assets/" + data['userImg'];
    appointmentList.add(Appointment(
      patientName: "${data["firstName"]}",
      patienSurname: "${data["lastName"]}",
      appoitmentComment: "${data["comment"]}",
      appoitmentDate: "${data['date']}",
      appoitmentTime: "${data['time']}",
      phoneNumber: "${data["number"]}",
      imgLink: img,
    ));
    appointmentList[0].isFuture = false;
    return appointmentList;
  }

  static getAllAppointmentIDs() async {
    // FirebaseFirestore.instance
    //     .collection('Appointments')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    //     print(doc["firstName"]);
    //   });
    // });
<<<<<<< Updated upstream
    List<String> IDs = [];
    print("here is the id");
    FirebaseFirestore.instance
        .collection('Appointments')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                IDs.add(doc.id.toString());
              })
            });
    return IDs;
=======
    FirebaseFirestore.instance.collection('Appointments').get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {


        String img = "assets/" + doc['userImg'];
        appointmentList.add(Appointment(
          patientName: "${doc["firstName"]}",
          patienSurname: "${doc["lastName"]}",
          appoitmentComment: "${doc["comment"]}",
          appoitmentDate: "${doc['date']}",
          appoitmentTime: "${doc['time']}",
          phoneNumber: "${doc["number"]}",
          imgLink: img,
        ));
      print(doc.data());
      print(appointmentList.length);
        appointmentList[0].isFuture = false;

        //appointmentList.add(Appointment.getAppointmentFromDoc(doc.data()));
    })

    });


>>>>>>> Stashed changes
  }
}
