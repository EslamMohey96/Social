import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/modules/socialLayout/menu/settingsScreen/seetings.dart';
import 'package:social_app/modules/userScreens/loginScreen/logInScreen.dart';
import 'package:social_app/modules/userScreens/profile/editProfile.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/loginCubit/loginCubit.dart';
import 'package:social_app/shared/cubit/socialCubit/socialCubit.dart';
import 'package:social_app/shared/cubit/socialCubit/socialStates.dart';
import 'package:social_app/shared/network/local/cacheHelper.dart';

class socialLayout extends StatelessWidget {
  const socialLayout({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = socialCubit.get(context);
    return BlocConsumer<socialCubit, socialStates>(
        listener: (BuildContext context, socialStates state) {},
        builder: (BuildContext context, socialStates state) {
          return Scaffold(
            drawer: Drawer(
              backgroundColor: Colors.black,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      cubit.user_model!.name,
                      style: TextStyle(color: Colors.black),
                    ),
                    accountEmail: Text(
                      cubit.user_model!.email,
                      style: TextStyle(color: Colors.black),
                    ),
                    currentAccountPicture: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        cubit.user_model!.image,
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(cubit.user_model!.background),
                          fit: BoxFit.fill,
                        )),
                  ),
                  ListTile(
                    iconColor: Colors.red,
                    textColor: Colors.white,
                    leading: Icon(IconBroken.Edit_Square),
                    title: Text(
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        'Edit Profile'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => editProfile()),
                      );
                    },
                  ),
                  ListTile(
                    iconColor: Colors.red,
                    textColor: Colors.white,
                    leading: Icon(IconBroken.Heart),
                    title: Text(
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        'Favorites'),
                    onTap: () {},
                  ),
                  ListTile(
                    iconColor: Colors.red,
                    textColor: Colors.white,
                    leading: Icon(Icons.person),
                    title: Text(
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        'Friends'),
                    onTap: () {},
                  ),
                  ListTile(
                    iconColor: Colors.red,
                    textColor: Colors.white,
                    leading: Icon(IconBroken.Setting),
                    title: Text(
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        'Settings'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => settings()),
                      );
                    },
                  ),
                  ListTile(
                    iconColor: Colors.red,
                    textColor: Colors.white,
                    leading: Icon(
                      Icons.brightness_6_outlined,
                    ),
                    title: Text(
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        'Dark Mode'),
                    onTap: () {},
                  ),
                  ListTile(
                    iconColor: Colors.red,
                    textColor: Colors.white,
                    leading: Icon(
                      Icons.language,
                    ),
                    title: Text(
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        'Language'),
                    onTap: () {},
                  ),
                  ListTile(
                    iconColor: Colors.red,
                    textColor: Colors.white,
                    leading: Icon(IconBroken.Logout),
                    title: Text(
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        'Logout'),
                    onTap: () {
                      print(uIdConst);
                      cacheHelper
                          .setData(
                        key: 'uId',
                        value: '',
                      )
                          .then((value) {
                        uIdConst = cacheHelper.getData(
                          key: 'uId',
                        );
                      }).then((value) {
                        print(uIdConst);
                        myLoginCubit.get(context).changeUIdDone = false;
                        socialCubit.get(context).currentIndex = 0;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => logInScreen()),
                            (Route<dynamic> route) => false);
                      });
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(IconBroken.Notification),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(IconBroken.Search),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavyBar(
              backgroundColor: Colors.black,
              selectedIndex: cubit.currentIndex,
              onItemSelected: (value) => cubit.changeCurrentIndex(value),
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                    icon: Icon(IconBroken.Home),
                    title: Text("Home"),
                    activeColor: Colors.red),
                BottomNavyBarItem(
                    icon: Icon(IconBroken.Chat),
                    title: Text('Chats'),
                    activeColor: Colors.red),
                BottomNavyBarItem(
                    icon: Icon(IconBroken.User),
                    title: Text('Users'),
                    activeColor: Colors.red),
              ],
            ),
          );
        });
  }
}
