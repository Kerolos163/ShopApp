import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/cubit.dart';
import 'package:shop_app/Helper/DioHelper.dart';

import 'Helper/Share_Pref.dart';
import 'Screen/LogIn/LoginScreen.dart';
import 'Screen/ShopLayout.dart';
import 'Screen/pageview.dart';
import 'Theme/theme.dart';
import 'imp_func.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await Sharepref.init();
  var pview = Sharepref.getdata(key: 'pageview');
  Token = Sharepref.getdata(key: 'Token');
  print(Token);
  Widget Spacific_Screen;
  if (pview == null) {
    Spacific_Screen = pageview();
  } else {
    if (Token == null) {
      Spacific_Screen = LoginScreen();
    } else {
      Spacific_Screen = ShopLayoutScreen();
    }
  }
  runApp(MyApp(
    open_Screen: Spacific_Screen,
  ));
}

class MyApp extends StatelessWidget {
  Widget open_Screen;
  MyApp({required this.open_Screen});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            ..getHomemodel()
            ..getcategoriesmodel()
            ..getFavoritesmodel()
            ..getUserData(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: primaryClr,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: primaryClr,
              unselectedItemColor: Colors.grey[300],
            )),
        home: open_Screen,
      ),
    );
  }
}
