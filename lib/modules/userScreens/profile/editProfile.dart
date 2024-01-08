import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/socialCubit/socialCubit.dart';
import 'package:social_app/shared/cubit/socialCubit/socialStates.dart';

class editProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialCubit, socialStates>(
      listener: (BuildContext context, socialStates state) {},
      builder: (BuildContext context, socialStates state) {
        socialCubit cubit = socialCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "edit profile",
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 190,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4),
                                ),
                                image: DecorationImage(
                                  image: cubit.coverImage == null
                                      ? NetworkImage(
                                          cubit.user_model!.background,
                                        )
                                      : Image.file(File(cubit.coverImage!.path))
                                          .image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.topLeft,
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0),
                              radius: 20,
                              child: IconButton(
                                onPressed: () {
                                  cubit.getCover();
                                },
                                icon: Icon(
                                  IconBroken.Camera,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 53,
                            backgroundColor: Colors.black,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: cubit.profileImage == null
                                  ? NetworkImage(
                                      cubit.user_model!.image,
                                    )
                                  : Image.file(File(cubit.profileImage!.path))
                                      .image,
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0),
                            radius: 20,
                            child: IconButton(
                              onPressed: () {
                                cubit.getImage();
                              },
                              icon: Icon(
                                IconBroken.Camera,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Form(
                  key: cubit.formKey,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state is updateUserDataLoadingState)
                          LinearProgressIndicator(
                            color: Colors.red,
                          ),
                        sizeBoxH(10),
                        textFormField(
                          context: context,
                          controller: cubit.nameController,
                          textInputType: TextInputType.text,
                          labelText: "Name",
                          prefixIcon: Icon(IconBroken.Profile),
                          valid: (value) {
                            if (value!.isEmpty) {
                              return 'User Name must\'n be empty ';
                            }
                            return null;
                          },
                        ),
                        sizeBoxH(10),
                        textFormField(
                          context: context,
                          controller: cubit.bioController,
                          textInputType: TextInputType.text,
                          labelText:
                              //

                              "Bio",
                          prefixIcon: Icon(IconBroken.Info_Circle),
                          valid: (value) {
                            if (value!.isEmpty) {
                              value = "";
                            }
                            return null;
                          },
                        ),
                        sizeBoxH(10),
                        textFormField(
                          context: context,
                          controller: cubit.phoneController,
                          textInputType: TextInputType.phone,
                          labelText: "phone number",
                          prefixIcon: Icon(IconBroken.Call),
                          valid: (value) {
                            if (value!.isEmpty) {
                              return 'phone number must\'n be empty ';
                            }
                            return null;
                          },
                        ),
                        sizeBoxH(10),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red),
                            ),
                            onPressed: () {
                              if (cubit.formKey.currentState!.validate()) {
                                cubit.updateUserData();
                              }
                            },

                            child: Text(
                              "Update",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                            //
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
