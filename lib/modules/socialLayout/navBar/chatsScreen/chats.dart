import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/socialLayout/navBar/chatsScreen/chatDetails.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/socialCubit/socialCubit.dart';
import 'package:social_app/shared/cubit/socialCubit/socialStates.dart';

class chats extends StatelessWidget {
  late socialCubit cubit;

  @override
  Widget build(BuildContext context) {
    cubit = socialCubit.get(context);
    return Builder(builder: (context) {
      cubit.getUsers();
      return BlocConsumer<socialCubit, socialStates>(
        listener: ((context, state) {}),
        builder: ((context, state) {
          return SingleChildScrollView(
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => userProfile(context, index),
              separatorBuilder: (context, index) => sizeBoxH(10),
              itemCount: cubit.users!.length,
            ),
          );
        }),
      );
    });
  }

  Widget userProfile(context, index) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () {
          cubit.massages_list = [];
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => chatDetails(cubit.users![index])));
        },
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
                      backgroundImage: NetworkImage(cubit.users![index].image),
                    ),
                    sizeBoxW(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cubit.users![index].name,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
