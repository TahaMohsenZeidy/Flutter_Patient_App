import 'package:bloc/bloc.dart';
import 'package:patient_app/LaboratoryAssistant/edit_profile.dart';

import 'package:patient_app/LaboratoryAssistant/hospital-dashboard-home.dart';
import 'package:patient_app/LaboratoryAssistant/Scan.dart';
import 'package:patient_app/LaboratoryAssistant/profile_screen.dart';

enum NavigationEvents {
  DashboardClickedEvent,
  ProfileScreenClickedEvent,
  NewCaseClickedEvent,
  ProfilePageClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc() : super(HomePage1());
  NavigationStates get initialState => HomePage1();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.DashboardClickedEvent:
        yield HomePage1();
        break;
      case NavigationEvents.NewCaseClickedEvent:
        yield ScanPage();
        break;
      case NavigationEvents.ProfilePageClickedEvent:
        yield ProfilePage();
        break;

      case NavigationEvents.ProfileScreenClickedEvent:
        yield EditProfile();
        break;
    }
  }
}
