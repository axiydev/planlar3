import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:planlar/pages/daily_page.dart';
import 'package:planlar/pages/detail_page.dart';
import 'package:planlar/pages/home_page.dart';
import 'package:planlar/pages/signin_page.dart';
import 'package:planlar/pages/signup_page.dart';
import 'package:planlar/pages/splash_page.dart';
import 'package:planlar/services/prefs_service.dart';
import 'package:planlar/theme.dart';
import 'package:planlar/widgets/chart_widget.dart';
import 'package:planlar/widgets/indicator_pro.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget _statrtPage(){
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder:(context,snapshot){
          if(snapshot.hasData){
            Prefs.saveUserId(snapshot.data.uid);
            return SplashScreen();
          }else{
            Prefs.removeUserId();
            return SignIn();
          }
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: basicTheme(context),
      home:_statrtPage(),
      routes:{
        SplashScreen.id:(context)=>SplashScreen(),
        DailyPage.id:(context)=>DailyPage(),
        HomeScreen.id:(context)=>HomeScreen(),
        DetailPage.id:(context)=>DetailPage(),
        SignIn.id:(context)=>SignIn(),
        SignUp.id:(context)=>SignUp(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}


