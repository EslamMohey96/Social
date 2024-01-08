import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/socialCubit/socialCubit.dart';
import 'package:social_app/shared/cubit/socialCubit/socialStates.dart';

class settings extends StatelessWidget {
  const settings({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = socialCubit.get(context);
    return BlocConsumer<socialCubit, socialStates>(
      listener: ((context, state) {}),
      builder: ((context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: cubit.user_model_Done != 0
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 190,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
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
                                      image: NetworkImage(
                                        cubit.user_model!.background,
                                      ),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                            ),
                            CircleAvatar(
                              radius: 53,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                  cubit.user_model!.image,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        cubit.user_model!.name,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        cubit.user_model!.bio,
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      sizeBoxH(20),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    "${cubit.myPosts.length}",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "Posts",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    "250",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "Photo",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    "250",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "Followers",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    "250",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "Following",
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        );
      }),
    );
  }
}
