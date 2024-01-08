import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/layout/socialLayout.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/socialCubit/socialCubit.dart';
import 'package:social_app/shared/cubit/socialCubit/socialStates.dart';

class createPost extends StatelessWidget {
  late socialCubit cubit;
  @override
  Widget build(BuildContext context) {
    cubit = socialCubit.get(context);
    return BlocConsumer<socialCubit, socialStates>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(cubit.user_model!.image),
                    ),
                    sizeBoxW(20),
                    Text(
                      cubit.user_model!.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red),
                      ),
                      onPressed: () {
                        if (cubit.formKeyPost.currentState!.validate()) {
                          cubit.createPost();
                          cubit.filePostImage = '';
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => socialLayout()),
                          );
                        }
                      },
                      child: Text(
                        "Post",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
                sizeBoxH(20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          child: Form(
                            key: cubit.formKeyPost,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              expands: true,
                              maxLines: null,
                              controller: cubit.postController,
                              decoration: InputDecoration(
                                  hintText: "what is in your mind ...",
                                  hintStyle: TextStyle(color: Colors.white70),
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value!.isEmpty &&
                                    (cubit.filePostImage == '')) {
                                  print('Post done');
                                  return 'please write something or add a photo';
                                }
                                return null;
                              },
                              onTap: () {},
                            ),
                          ),
                        ),
                        sizeBoxH(20),
                        if (state is getPostImageLoading)
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        if (cubit.filePostImage != '')
                          Image(
                            image: NetworkImage(
                              cubit.filePostImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    cubit.getPostImage();
                  },
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Image,
                        color: Colors.red,
                      ),
                      sizeBoxW(5),
                      Text(
                        "add photo",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
