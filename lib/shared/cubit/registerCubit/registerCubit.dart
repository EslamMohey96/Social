import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/registerCubit/registerStatus.dart';
import 'package:social_app/shared/cubit/socialCubit/socialCubit.dart';
import 'package:social_app/shared/network/local/cacheHelper.dart';

class registerCubit extends Cubit<registerStates> {
  registerCubit() : super(registerInitStatus());
  static registerCubit get(context) => BlocProvider.of(context);

  GlobalKey<FormState> formKey = GlobalKey();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  bool visiblePassword = false;

  void changeVisiblePassword(bool pass) {
    visiblePassword = pass;
    emit(registervisiblePasswordState());
  }

  bool registerDone = true;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    context,
    String bio = "write your bio",
    String background =
        "https://img.freepik.com/free-vector/paper-style-white-monochrome-background_52683-66443.jpg?w=740&t=st=1704366685~exp=1704367285~hmac=fa0444a85ae4c705516111a8ea3d00b261fb9ab84c429dc7e70fb13a859d0bb1",
    String image =
        "https://img.freepik.com/premium-vector/man-avatar-profile-picture-vector-illustration_268834-538.jpg?w=740",
  }) async {
    registerDone = false;
    emit(registerLoadingState());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (value) {
          userCreate(
              name: name,
              email: email,
              phone: phone,
              uId: value.user!.uid,
              image: image,
              background: background,
              bio: bio,
              context: context);
        },
      );
    } on FirebaseAuthException catch (e) {
      registerDone = true;
      switch (e.code) {
        case 'weak-password':
          emit(registerErrorState('Password should be at least 6 characters'));
          break;
        case 'invalid-email':
          emit(registerErrorState('The email address is badly formatted'));
          break;
        case 'email-already-in-use':
          emit(registerErrorState('The email is already exists'));
          break;
        case 'too-many-requests':
          emit(registerErrorState('too many requests, please try later'));
          break;
        default:
          emit(registerErrorState(e.message));
      }
    }
  }

  void userCreate(
      {required String name,
      required String email,
      required String phone,
      required String uId,
      required String image,
      required String background,
      required String bio,
      context}) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uId).set({
        'email': email,
        'uId': uId,
        'name': name,
        'phone': phone,
        'isEmailVerified': false,
        'image': image,
        'background': background,
        'bio': bio
      }).then((value) {
        changeUId(uId, context);
      });
    } on FirebaseAuthException catch (e) {
      emit(userDataRegErrorState(e.message));
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
      socialCubit.get(context)..getUserData(uIdConst);
      print(uIdConst);
      registerDone = true;
      changeUIdDone = true;
      emit(changeUIdDoneState());
    });
  }
}
