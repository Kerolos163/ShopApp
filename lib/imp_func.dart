import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Helper/Share_Pref.dart';
import 'Screen/LogIn/LoginScreen.dart';

  var Token = Sharepref.getdata(key: 'Token');
Size mediaquery(context) => MediaQuery.of(context).size;

void go_to(context, screen) => Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => screen,
    ));

void go_toAnd_finish(context, screen) => Navigator.of(context)
    .pushReplacement(MaterialPageRoute(builder: (BuildContext ctx) => screen));

IconButton PassIcon(Widget Icon, Function func) => IconButton(
      icon: Icon,
      color: Colors.black,
      onPressed: () => func(),
    );

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseColor({required ToastState state}) {
  switch (state) {
    case ToastState.SUCCESS:
      return Colors.orange;
    case ToastState.ERROR:
      return Colors.red;
    case ToastState.WARNING:
      return Colors.amber;
    default:
      return Colors.grey[900]!;
  }
}

Future<bool?> ShowToast({required String txt, required ToastState state}) =>
    Fluttertoast.showToast(
        msg: txt,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseColor(state: state),
        textColor: Colors.white,
        fontSize: 16.0);

void SignOut(context) {
  Sharepref.deletedata(key: 'Token').then((value) {
    go_toAnd_finish(context, LoginScreen());
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
