import 'package:cloud_firestore/cloud_firestore.dart';

import 'patient.dart';

class Appointment extends Patient {
  Appointment(
      {this.appoitmentComment,
      this.appoitmentDate,
      this.appoitmentTime,
      this.imgLink,
      this.patienSurname,
      this.patientName,
      this.phoneNumber})
      : super.named(patientName,imgLink,phoneNumber,patienSurname);

  String patientName, patienSurname, imgLink, phoneNumber;
  String appoitmentDate;
  String appoitmentTime;
  String appoitmentComment;
  bool isFuture=true;


  static Appointment getAppointmentFromDoc( QueryDocumentSnapshot data){
    print(data['userImg']);

    return Appointment(
      patientName: "${data["firstName"]}",
      patienSurname: "${data["lastName"]}",
      appoitmentComment: "${data["comment"]}",
      appoitmentDate: "${data['date']}",
      appoitmentTime: "${data['time']}",
      phoneNumber: "${data["number"]}",
      imgLink: "assets/${data['userImg']}",
    );

  }


}
