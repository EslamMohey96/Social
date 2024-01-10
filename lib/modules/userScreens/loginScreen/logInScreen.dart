import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/layout/socialLayout.dart';
import 'package:social_app/modules/userScreens/registerScreen/registerScreen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/loginCubit/loginCubit.dart';
import 'package:social_app/shared/cubit/loginCubit/loginStates.dart';

class logInScreen extends StatelessWidget {
  late myLoginCubit cubit;

  @override
  Widget build(BuildContext context) {
    cubit = myLoginCubit.get(context);
    return BlocConsumer<myLoginCubit, myLoginStates>(
      listener: (BuildContext context, myLoginStates state) {
        if (cubit.changeUIdDone == true) {
          print(uIdConst);
          Fluttertoast.showToast(
            msg: "Login done successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          myLoginCubit.get(context).emailController.text = '';
          myLoginCubit.get(context).passwordController.text = '';
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => socialLayout()),
              (Route<dynamic> route) => false);
        }
      },
      builder: (BuildContext context, myLoginStates state) {
        myLoginCubit cubit = myLoginCubit.get(context);
        return Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            body: Container(
              color: Colors.black,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: cubit.formKey,
                        child: Column(
                          children: [
                            FadeInDown(
                              delay: Duration(milliseconds: 300),
                              duration: Duration(milliseconds: 1500),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Social',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      // : Text(
                                      //     'متجر',
                                      //     style: TextStyle(
                                      //       color: Colors.red,
                                      //       fontSize: 40,
                                      //       fontWeight: FontWeight.bold,
                                      //     ),
                                      //   ),
                                      sizeBoxW(10),

                                      Text(
                                        'App',
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      //
                                    ],
                                  ),

                                  Text(
                                    'Login now to communicate with your friends.',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  //
                                ],
                              ),
                            ),
                            sizeBoxH(20),
                            FadeInRight(
                              delay: Duration(milliseconds: 300),
                              duration: Duration(milliseconds: 1500),
                              child: Container(
                                width: cubit.constraints!>450?450 :double.infinity,
                                child: textFormField(
                                  context: context,
                                  controller: cubit.emailController,
                                  textInputType: TextInputType.emailAddress,
                                  labelText: "Email Address",
                                  prefixIcon: Icon(IconBroken.Profile),
                                  valid: (value) {
                                    if (value!.isEmpty) {
                                      return 'email must\'n be empty ';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            sizeBoxH(20),
                            FadeInLeft(
                              delay: Duration(milliseconds: 300),
                              duration: Duration(milliseconds: 1500),
                              child: Container(
                                width: cubit.constraints!>450?450 :double.infinity,
                                child: textFormField(
                                  context: context,
                                  controller: cubit.passwordController,
                                  textInputType: TextInputType.visiblePassword,
                                  visible: !cubit.visiblePassword,
                                  labelText: "Password",
                                  prefixIcon: Icon(IconBroken.Lock),
                                  suffixIcon: cubit.visiblePassword
                                      ? Icon(Icons.visibility_sharp)
                                      : Icon(Icons.visibility_off_sharp),
                                  suffixPressed: () {
                                    print(cubit.visiblePassword);
                                    cubit.changeVisiblePassword(
                                        !cubit.visiblePassword);
                                    print(cubit.visiblePassword);
                                  },
                                  valid: (value) {
                                    if (value!.isEmpty) {
                                      return 'password must\'n be empty ';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            sizeBoxH(20),
                            FadeInUp(
                              delay: Duration(milliseconds: 300),
                              duration: Duration(milliseconds: 1500),
                              child: Container(
                                width: cubit.constraints!>450?450 :double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: defaultButton(
                                  function: () {
                                    if (cubit.formKey.currentState!
                                        .validate()) {
                                      cubit.userLogin(
                                        context: context,
                                        email: cubit.emailController.text,
                                        password: cubit.passwordController.text,
                                      );
                                    }
                                  },
                                  widget: Text("LogIn"),
                                ),
                              ),
                              //
                            ),
                            sizeBoxH(10),
                            FadeInUp(
                              delay: Duration(milliseconds: 300),
                              duration: Duration(milliseconds: 1500),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("don\'t have an account?"),
                                  TextButton(
                                    onPressed: () {
                                      cubit.emailController.text = '';
                                      cubit.passwordController.text = '';
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                 registerScreen()),
                                      );
                                    },
                                    child: Text(
                                      'Register Now',
                                      style: const TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                    //
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
