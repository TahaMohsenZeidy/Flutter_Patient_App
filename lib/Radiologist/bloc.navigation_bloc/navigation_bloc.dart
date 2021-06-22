import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:patient_app/Radiologist/edit_profile.dart';

import 'package:patient_app/Radiologist/profile_screen.dart';

import 'package:patient_app/Radiologist/hospital-dashboard-home.dart';
import 'package:patient_app/Radiologist/Scan.dart';
import 'package:patient_app/Radiologist/data.dart';

enum NavigationEvents {
  DashboardClickedEvent,

  NewCaseClickedEvent,

  EditProfileClickedEvent,
  ProfilePageClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc() : super(HomePage1());
  NavigationStates get initialState => HomePage1();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.DashboardClickedEvent:
        yield HomePage1();
        break;
      case NavigationEvents.NewCaseClickedEvent:
        yield ScanPage();
        break;
      case NavigationEvents.EditProfileClickedEvent:
        yield EditProfile();
        break;
      case NavigationEvents.ProfilePageClickedEvent:
        yield ProfilePage();
        break;
    }
  }
}
