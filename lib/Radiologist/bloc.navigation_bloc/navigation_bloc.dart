import 'package:bloc/bloc.dart';
import 'package:patient_app/Radiologist/NewCase.dart';
import 'package:patient_app/Radiologist/ProfilePage.dart';
import 'package:patient_app/Radiologist/hospital-dashboard-home.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  DashboardClickedEvent,
  ProfileScreenClickedEvent,
  NewCaseClickedEvent,
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
        yield NewCase();
        break;

      case NavigationEvents.ProfileScreenClickedEvent:
        yield ProfilePage();
        break;
      case NavigationEvents.HomePageClickedEvent:
        // TODO: Handle this case.
        break;
    }
  }
}
