import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/layout/socialLayout.dart';
import 'package:social_app/modules/userScreens/loginScreen/logInScreen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/registerCubit/registerCubit.dart';
import 'package:social_app/shared/cubit/registerCubit/registerStatus.dart';

class registerScreen extends StatelessWidget {
  const registerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    registerCubit cubit = registerCubit.get(context);
    return BlocConsumer<registerCubit, registerStates>(
      listener: (BuildContext context, registerStates state) {
        if (cubit.changeUIdDone) {
          Fluttertoast.showToast(
            msg: "Registration Done",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          cubit.emailController.text = '';
          cubit.nameController.text = '';
          cubit.passwordController.text = '';
          cubit.phoneController.text = '';

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => socialLayout()),
              (Route<dynamic> route) => false);
        }
      },
      builder: (BuildContext context, registerStates state) {
        return Scaffold(
          body: Container(
            color: Colors.black,
            padding: const EdgeInsets.all(20.0),
            child: Center(
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

                                sizeBoxW(10),

                                Text(
                                  'Appp',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                //
                              ],
                            ),

                            Text(
                              'SignUp now to communicate with your friends.',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                //
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
                        child: textFormField(
                          context: context,
                          controller: cubit.nameController,
                          textInputType: TextInputType.text,
                          labelText: "Name",
                          prefixIcon: Icon(IconBroken.Profile),
                          valid: (value) {
                            if (value!.isEmpty) {
                              return 'Name must\'n be empty ';
                            }
                          },
                        ),
                      ),
                      sizeBoxH(20),
                      FadeInLeft(
                        delay: Duration(milliseconds: 300),
                        duration: Duration(milliseconds: 1500),
                        child: textFormField(
                          context: context,
                          controller: cubit.emailController,
                          textInputType: TextInputType.emailAddress,
                          labelText: "Email Address",
                          prefixIcon: Icon(IconBroken.Message),
                          valid: (value) {
                            if (value!.isEmpty) {
                              return 'email must\'n be empty ';
                            }
                            return null;
                          },
                        ),
                      ),
                      sizeBoxH(20),
                      FadeInRight(
                        delay: Duration(milliseconds: 300),
                        duration: Duration(milliseconds: 1500),
                        child: textFormField(
                          context: context,
                          controller: cubit.phoneController,
                          textInputType: TextInputType.phone,
                          labelText: "Phone",
                          prefixIcon: Icon(IconBroken.Call),
                          valid: (value) {
                            if (value!.isEmpty) {
                              return 'phone must\'n be empty ';
                            }
                          },
                        ),
                      ),
                      sizeBoxH(20),
                      FadeInLeft(
                        delay: Duration(milliseconds: 300),
                        duration: Duration(milliseconds: 1500),
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
                            cubit.changeVisiblePassword(!cubit.visiblePassword);
                            print(cubit.visiblePassword);
                          },
                          valid: (value) {
                            if (value!.isEmpty) {
                              return 'password must\'n be empty ';
                            }
                          },
                        ),
                      ),
                      sizeBoxH(20),
                      FadeInUp(
                        delay: Duration(milliseconds: 300),
                        duration: Duration(milliseconds: 1500),
                        child: cubit.registerDone
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: defaultButton(
                                  function: () {
                                    if (cubit.formKey.currentState!
                                        .validate()) {
                                      cubit.userRegister(
                                        context: context,
                                        name: cubit.nameController.text,
                                        phone: cubit.phoneController.text,
                                        email: cubit.emailController.text,
                                        password: cubit.passwordController.text,
                                      );
                                    }
                                  },
                                  widget: Text("SignUp"),
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                color: Colors.red,
                              )),
                      ),
                      sizeBoxH(10),
                      FadeInUp(
                        delay: Duration(milliseconds: 300),
                        duration: Duration(milliseconds: 1500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("you have have an account?"),
                            TextButton(
                              onPressed: () {
                                cubit.emailController.text = '';
                                cubit.nameController.text = '';
                                cubit.passwordController.text = '';
                                cubit.phoneController.text = '';
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => logInScreen()),
                                );
                              },
                              child: Text(
                                'SignIn now',
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
