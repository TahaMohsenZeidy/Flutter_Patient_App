import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:patient_app/Doctor/data/randomData.dart' as RDT;
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

  @override
  void initState() {
    super.initState();
    topHeader = [];
    currentAppointment = [];
    midHeader = [];
    futureAppointment = [];
    finalList = [];
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (isFirstTime == false) {
      initiateList();
      isFirstTime = true;
    }
    return FutureBuilder<DocumentSnapshot>(
      future: appointmentsRef.doc("Kj84RycRkrldJRXrP1Z2").get(),
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
                    print(finalList.length);
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
    );
  }

  Future<bool> initiateList() async {

    //First we work on the header of the list
    topHeader.add(
      Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 9, top: 7),
        child: new Container(
          width: SizeConfig.safeBlockHorizontal * 90,
          height: SizeConfig.verticalBloc * 3,
          //color: Colors.pink,
          child: Text(
            'Bienvenue !',
            style: TextStyle(
                fontSize: SizeConfig.horizontalBloc * 6, color: Colors.black45),
          ),
        ),
      ),
    );
    topHeader.add(
      Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 15),
        child: new Container(
          width: SizeConfig.safeBlockHorizontal * 90,
          height: SizeConfig.verticalBloc * 5,
          //color: Colors.pink,
          child: Text(
            'Dr. @Taha',
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
    var currentTime = DateTime.now();
    String imgLink;
    imgLink = 'assets/user0.jpg';
    for(int i=0; i<3; i++){
      appointmentList.add(Appointment(
        patientName: "${data['patient_full_name']}",
        appoitmentComment: RDT.comments[i],
        appoitmentDate: '',
        appoitmentTime: '$currentTime',
        phoneNumber: '50056505',
        imgLink: imgLink,
      ));
      appointmentList[i].isFuture = true;
    }
    return appointmentList;
  }
}

