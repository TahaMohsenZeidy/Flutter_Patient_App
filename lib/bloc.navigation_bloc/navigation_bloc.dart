import 'package:bloc/bloc.dart';
import 'package:patient_app/screens/appointmentScreen/appointmentScreen.dart';
import 'package:patient_app/screens/profile_screen.dart';
import '../hospital-dashboard-home.dart';
import '../new_patient.dart';


enum NavigationEvents {
  HomePageClickedEvent,
  NewPatientClickedEvent,
  DashboardClickedEvent,
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
      case NavigationEvents.DashboardClickedEvent:
        yield HomePage1();
        break;

      case NavigationEvents.NewPatientClickedEvent:
        yield NewPatient();
        break;
      case NavigationEvents.ProfileScreenClickedEvent:
        yield ProfileScreen();
        break;
    }
  }
}
