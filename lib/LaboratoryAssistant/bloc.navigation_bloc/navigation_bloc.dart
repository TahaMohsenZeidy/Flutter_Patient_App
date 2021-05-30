import 'package:bloc/bloc.dart';
import 'package:patient_app/LaboratoryAssistant/NewCase.dart';
import 'package:patient_app/LaboratoryAssistant/Radiologist_Profile .dart';
import 'package:patient_app/LaboratoryAssistant/hospital-dashboard-home.dart';

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
        yield LaboratoryNewCase();
        break;

      case NavigationEvents.ProfileScreenClickedEvent:
        yield Analist_Profile();
        break;
      case NavigationEvents.HomePageClickedEvent:
        // TODO: Handle this case.
        break;
    }
  }
}
