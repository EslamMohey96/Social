import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/modules/socialLayout/createPost/createPost.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/socialCubit/socialCubit.dart';
import 'package:social_app/shared/cubit/socialCubit/socialStates.dart';

class feeds extends StatelessWidget {
  late socialCubit cubit;

  @override
  Widget build(BuildContext context) {
    cubit = socialCubit.get(context);

    return Builder(builder: (context) {
      cubit.getMyPosts();

      return BlocConsumer<socialCubit, socialStates>(
        listener: ((context, state) {}),
        builder: ((context, state) {
          return cubit.user_model_Done == 0
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    'https://img.freepik.com/free-photo/three-male-friends-standing-against-white-wall-pointing-finger-upward-looking-camera_23-2148160171.jpg?w=826&t=st=1704646505~exp=1704647105~hmac=13c1abffaf8a6529a271f04b3043c7a8f51fdc0c34eeb5e95ffd8398a75c0955',
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Text(
                            'communicate with your friends now.',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                      sizeBoxH(15),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Card(
                          color: Colors.grey.withOpacity(0.3),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 10,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          NetworkImage(cubit.user_model!.image),
                                    ),
                                    sizeBoxW(10),
                                    Expanded(
                                      child: InkWell(
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.black),
                                          child: Text(
                                            "write a post",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    createPost()),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      sizeBoxH(15),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            postWidget(context, index),
                        separatorBuilder: (context, index) => sizeBoxH(10),
                        itemCount: cubit.myPosts.length,
                      ),
                    ],
                  ),
                );
        }),
      );
    });
  }

  Widget postWidget(context, index) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        color: Colors.grey.withOpacity(0.3),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(cubit.myPosts[index].image),
                  ),
                  sizeBoxW(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cubit.myPosts[index].name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      sizeBoxH(5),
                      Text(
                        cubit.myPosts[index].date,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    color: Colors.red,
                    onPressed: () {},
                    icon: Icon(IconBroken.More_Circle),
                  ),
                  sizeBoxW(10),
                ],
              ),
              sizeBoxH(15),
              if (cubit.myPosts[index].postText != '')
                Text(
                  cubit.myPosts[index].postText,
                  style: TextStyle(fontSize: 15),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              sizeBoxH(10),
              if (cubit.myPosts[index].postImage != '')
                Image(
                    image: NetworkImage(
                      cubit.myPosts[index].postImage,
                    ),
                    fit: BoxFit.cover),
              sizeBoxH(10),
              Row(
                children: [
                  sizeBoxW(5),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                        ),
                        Text(
                          "5",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  Spacer(),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          Icons.comment,
                          color: Colors.red,
                        ),
                        Text(
                          "5 comments",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  sizeBoxW(5),
                ],
              ),
              sizeBoxH(10),
              Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(cubit.user_model!.image),
                  ),
                  sizeBoxW(10),
                  Expanded(
                      child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "write to comment",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    onTap: () {},
                  )),
                  // Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      IconBroken.Heart,
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget statuWidget() {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            width: 80,
            height: 150,
            image: NetworkImage(
              "https://img.freepik.com/free-photo/school-scene-with-queer-teens_23-2150379377.jpg?w=826&t=st=1704284143~exp=1704284743~hmac=3ae0238ca1ce2d90c1f28572167c10330bb5046c552c6acd1d2801cebc0ca18c",
            ),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "name",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}
