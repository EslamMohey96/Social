import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/loginCubit/loginStates.dart';
import 'package:social_app/shared/cubit/socialCubit/socialCubit.dart';
import 'package:social_app/shared/network/local/cacheHelper.dart';

class myLoginCubit extends Cubit<myLoginStates> {
  myLoginCubit() : super(myLoginInitState());
  GlobalKey<FormState> formKey = GlobalKey();
  static myLoginCubit get(context) => BlocProvider.of(context);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  List li = [];

  int? constraints ;
  void changeConstraints(int constraints) {
    this.constraints = constraints;
    emit(changeConstraintsState());
  }


  bool visiblePassword = false;
  void changeVisiblePassword(bool pass) {
    visiblePassword = pass;
    emit(myLogvisiblePasswordState());
  }

  bool loginDone = false;
  userLogin({
    context,
    required email,
    required password,
  }) async {
    emit(loginLoadingState());

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        print(value.user!.uid);
        print("Login Successfully");
        changeUId(value.user!.uid, context);
        emit(loginSuccessState(value.user!.uid));
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
          emit(loginErrorState('please verify email and password'));
          break;
        case 'invalid-email':
          emit(loginErrorState('The email address is badly formatted'));
          break;
        case 'too-many-requests':
          emit(loginErrorState('too many requests, please try later'));
          break;
        default:
          emit(loginErrorState(e.message));
      }
    }
  }

  bool changeUIdDone = false;
  changeUId(id, context) {
    changeUIdDone = false;
    print(uIdConst);

    cacheHelper
        .setData(
      key: 'uId',
      value: id,
    )
        .then((value) {
      uIdConst = cacheHelper.getData(
        key: 'uId',
      );
    }).then((value) {
      socialCubit.get(context).getUserData(uIdConst);
      print(uIdConst);

      changeUIdDone = true;
      emit(changeUIdDoneState());
    });
  }
}
