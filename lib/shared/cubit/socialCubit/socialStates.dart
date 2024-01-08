import 'package:social_app/shared/components/components.dart';

abstract class socialStates {}
// initState
class socialInitState extends socialStates {}


// changeNavState
class changeNavState extends socialStates {}

// getUserData
class userDataLoadingState extends socialStates {}

class userDataSuccessState extends socialStates {}

class userDataErrorState extends socialStates {
  late final dynamic error;
  userDataErrorState(this.error) {
    toastMessage(message: error);
  }
}

// getMassages
class getMassageSuccessState extends socialStates {}

class getMassageErrorState extends socialStates {
  late final dynamic error;
  getMassageErrorState(this.error) {
    toastMessage(message: error);
  }
}

// sendMassage
class sendMassageSuccessState extends socialStates {}

class sendMassageErrorState extends socialStates {
  late final dynamic error;
  sendMassageErrorState(this.error) {
    toastMessage(message: error);
  }
}

// get Users
class usersLoadingState extends socialStates {}

class usersSuccessState extends socialStates {}

class usersErrorState extends socialStates {
  late final dynamic error;
  usersErrorState(this.error) {
    toastMessage(message: error);
  }
}

// update User Data
class updateUserDataLoadingState extends socialStates {}

class updateUserDataSuccessState extends socialStates {}

class updateUserDataErrorState extends socialStates {
  late final dynamic error;
  updateUserDataErrorState(this.error) {
    toastMessage(message: error);
  }
}

// get Posts States
class myPostsLoadingState extends socialStates {}

class myPostsSuccessState extends socialStates {}

class myPostsErrorState extends socialStates {
  late final dynamic error;
  myPostsErrorState(this.error) {
    toastMessage(message: error);
  }
}

// create Post Error
class createPostErrorState extends socialStates {
  late final dynamic error;
  createPostErrorState(this.error) {
    toastMessage(message: error);
  }
}

// profile Image states
class profileImageSuccessState extends socialStates {}

class profileImageErrorState extends socialStates {
  late final dynamic error;
  profileImageErrorState(this.error) {
    toastMessage(message: error);
  }
}

// cover Image states
class coverImageSuccessState extends socialStates {}

class coverImageErrorState extends socialStates {
  late final dynamic error;
  coverImageErrorState(this.error) {
    toastMessage(message: error);
  }
}

// post Image states
class getPostImageLoading extends socialStates {}

class postImageSuccessState extends socialStates {}

class postImageErrorState extends socialStates {
  late final dynamic error;
  postImageErrorState(this.error) {
    toastMessage(message: error);
  }
}
