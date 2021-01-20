import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planlar/constants/constants.dart';
ThemeData basicTheme(BuildContext context)=>ThemeData(
  textTheme: TextTheme(
    // headline3:,
    // headline4:,
    // headline6: ,
    // bodyText1: ,
    // subtitle1: ,
    // caption: ,
    button:TextStyle(
      color: greenColorWidget,
    ),

  ),
  scaffoldBackgroundColor: Color.fromRGBO(253, 243, 233,1),
  primaryColor:Color.fromRGBO(253, 243, 233,1),
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);