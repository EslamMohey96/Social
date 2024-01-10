import 'package:firebase_core/firebase_core.dart';
import 'package:social_app/layout/socialLayout.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/cubit/loginCubit/loginStates.dart';
import 'package:social_app/shared/cubit/socialCubit/socialCubit.dart';
import 'package:social_app/shared/network/local/cacheHelper.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/userScreens/loginScreen/logInScreen.dart';
import 'package:social_app/shared/components/blocObserver.dart';
import 'package:social_app/shared/cubit/loginCubit/loginCubit.dart';
import 'package:social_app/shared/cubit/registerCubit/registerCubit.dart';
import 'package:social_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then(
      (value) => print("done ${Firebase.app().options.projectId.toString()}"));

  Bloc.observer = blocObserver();
  // dioHelper.init();
  await cacheHelper.init();

  Widget startPage;
  uIdConst = cacheHelper.getData(key: 'uId') ?? '';
  bool? isLogin = uIdConst == '' ? false : true;
  if (uIdConst == '') {
    startPage = logInScreen();
  } else {
    startPage = socialLayout();
  }
  runApp(MyApp(
    startPage,
  ));
}

class MyApp extends StatelessWidget {
  Widget startPage;
  MyApp(
    this.startPage,
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => myLoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => registerCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              socialCubit()..getUserData(uIdConst),
        ),
      ],
      child: BlocConsumer<myLoginCubit, myLoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            darkTheme: darkMode,
            themeMode: ThemeMode.dark,
            home: LayoutBuilder(builder: (context, constraints) {
              myLoginCubit.get(context).changeConstraints(constraints.minWidth as int);
              return startPage;
            }),
          );
        },
      ),
    );
  }
}
