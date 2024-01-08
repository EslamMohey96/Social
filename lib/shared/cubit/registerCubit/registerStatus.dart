
import 'package:social_app/shared/components/components.dart';

abstract class registerStates {}

class registerInitStatus extends registerStates {}

class changeUIdDoneState extends registerStates {}

class registervisiblePasswordState extends registerStates {}


//registeration
class registerLoadingState extends registerStates {}

class registerSuccessState extends registerStates {}

class registerErrorState extends registerStates {
  late final dynamic error;
  registerErrorState(this.error) {
    toastMessage(message: error);
    print(error);
  }
}


// setting user data
class userDataRegLoadingState extends registerStates {}

class userDataRegSuccessState extends registerStates {}

class userDataRegErrorState extends registerStates {
  late final dynamic error;
  userDataRegErrorState(this.error) {
    toastMessage(message: error);
    print(error);
  }
}