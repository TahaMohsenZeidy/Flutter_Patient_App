import 'package:bloc/bloc.dart';
import 'package:patient_app/screens/appointmentScreen/appointmentScreen.dart';
import 'package:patient_app/screens/profile_screen.dart';
import 'package:patient_app/screens/resto_home_screen.dart';
import '../new_patient.dart';


enum NavigationEvents {
  HomePageClickedEvent,
  AddNewPatientClickedEvent,
  PatientListClickedEvent,
  ProfileScreenClickedEvent
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc() : super(AppointmentScreen());
  NavigationStates get initialState => AppointmentScreen();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield AppointmentScreen();
        break;
      case NavigationEvents.AddNewPatientClickedEvent:
        yield NewPatient();
        break;

      case NavigationEvents.PatientListClickedEvent:
        yield PatientsScreen();
        break;

      case NavigationEvents.ProfileScreenClickedEvent:
        yield ProfileScreen();
        break;
    }
  }
}
