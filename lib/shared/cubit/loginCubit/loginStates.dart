import 'package:social_app/shared/components/components.dart';

abstract class myLoginStates {}

class myLoginInitState extends myLoginStates {}

class myLogvisiblePasswordState extends myLoginStates {}

class changeUIdDoneState extends myLoginStates {}

class loginLoadingState extends myLoginStates {}

class loginSuccessState extends myLoginStates {
  late String uId;
  loginSuccessState(this.uId);
}

class loginErrorState extends myLoginStates {
  late final dynamic error;
  loginErrorState(this.error) {
    toastMessage(message: error);
  }
}
