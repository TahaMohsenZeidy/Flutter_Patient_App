import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:patient_app/Doctor/screens/appointmentScreen/appointmentScreen.dart';
import 'package:patient_app/Doctor/screens/profile_screen.dart';
import 'package:patient_app/Doctor/screens/resto_home_screen.dart';
import 'package:patient_app/Doctor/doctor_dashboard.dart';
import 'package:patient_app/Login.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  AddNewPatientClickedEvent,
  PatientListClickedEvent,
  ProfileScreenClickedEvent,
  DoctorDashClickedEvent,
  LogoutClickedEvent
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc() : super(AppointmentScreen());
  NavigationStates get initialState => AppointmentScreen();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield AppointmentScreen();
        break;
      case NavigationEvents.DoctorDashClickedEvent:
        yield DoctorDash();
        break;

      case NavigationEvents.PatientListClickedEvent:
        yield PatientsScreen();
        break;

      case NavigationEvents.ProfileScreenClickedEvent:
        yield ProfileScreen();
        break;

      case NavigationEvents.LogoutClickedEvent:
        // i need to logout first
        signOut();
        yield Login();
        break;
    }
  }

  void signOut() async{
    _auth.signOut();
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

}
