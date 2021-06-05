import 'package:patient_app/models/appointmentModels/Appointment.dart';
import '../data/randomData.dart' as RDT;

class AppointmentManager {
  static List<Appointment> appointmentList = [];
  static List generateAppointmentList() {
    var currentTime = DateTime.now();
    String imgLink;
    imgLink = 'assets/user0.jpg';
    for(int i=0; i<3; i++){
      appointmentList.add(Appointment(
        patientName: RDT.lastName[i],
        patienSurname: RDT.mames[i],
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
