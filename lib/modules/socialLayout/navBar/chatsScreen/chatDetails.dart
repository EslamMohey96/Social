import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:intl/intl.dart';
import 'package:social_app/models/userModel.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/socialCubit/socialCubit.dart';
import 'package:social_app/shared/cubit/socialCubit/socialStates.dart';

class chatDetails extends StatelessWidget {
  userModel user_model;
  chatDetails(this.user_model);
  late socialCubit cubit;
  @override
  Widget build(BuildContext context) {
    cubit = socialCubit.get(context);

    return Builder(
      builder: (context) {
        cubit.getMassage(receiver: user_model.uId);
final scrollController = ScrollController();
        return BlocConsumer<socialCubit, socialStates>(
          listener: ((context, state) {}),
          builder: ((context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(user_model.image),
                    ),
                    sizeBoxW(15),
                    Text(
                      user_model.name,
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      flex: 16,
                      child: ListView.separated(
                        // controller: scrollController,
                        itemBuilder: (context, index) {
                          if (cubit.massages_list[index].receiver ==
                              cubit.user_model!.uId) {
                            print(user_model.uId);
                            print(cubit.user_model!.uId);
                            return Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: Text(
                                  cubit.massages_list[index].text,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadiusDirectional.only(
                                      bottomEnd: Radius.circular(10),
                                      topEnd: Radius.circular(10),
                                      topStart: Radius.circular(10),
                                    )),
                              ),
                            );
                          } else if (cubit.massages_list[index].sender ==
                              cubit.user_model!.uId) {
                            print(user_model.uId);
                            print(cubit.user_model!.uId);
                            return Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: Text(
                                  cubit.massages_list[index].text,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadiusDirectional.only(
                                      bottomStart: Radius.circular(10),
                                      topEnd: Radius.circular(10),
                                      topStart: Radius.circular(10),
                                    )),
                              ),
                            );
                          }
                        },
                        separatorBuilder: (context, index) => sizeBoxH(10),
                        itemCount: cubit.massages_list.length,
                      ),
                    ),
                    sizeBoxH(10),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: cubit.chatController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '  type your massage',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  )),
                            ),
                          ),
                          Container(
                            height: 55,
                            color: Colors.red,
                            child: MaterialButton(
                              minWidth: 1,
                              onPressed: () {
                                cubit.sendMassage(
                                  receiver: user_model.uId,
                                  text: cubit.chatController.text,
                                );
                              },
                              child: Icon(IconBroken.Send),
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
      },
    );
  }
}
