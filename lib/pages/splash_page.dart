import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planlar/pages/home_page.dart';
import 'package:planlar/pages/signin_page.dart';
import 'package:planlar/services/prefs_service.dart';
import 'package:planlar/widgets/custom_widget.dart';
import 'package:planlar/pages/daily_page.dart';

class SplashScreen extends StatefulWidget {
  static final String id='splash_screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {

  _timer(){
    Timer(Duration(seconds: 5),(){
     Navigator.pushReplacementNamed(context,HomeScreen.id);
    });
  }
  @override
  void initState(){
    super.initState();
    _timer();
  }
  final double pi=3.14;
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body:SafeArea(
        child:Container(
          width: size.width,
          height: size.height,
          child:Stack(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.height*0.25,
                right: MediaQuery.of(context).size.width*0.3,
                child:Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape:BoxShape.circle,
                    color:Color.fromRGBO(254, 221,106, 0.8),
                  ),
                ),
              ),
              Positioned(
                  top: 20,
                  right: 0.0,
                  child: Transform.translate(
                    offset:Offset(60,10),
                    child: Transform(
                      transform: Matrix4.rotationZ(pi/3)..scale(2.0),
                      child: Container(
                        height: 60,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(192, 128, 84,0.9),
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(15),topLeft: Radius.circular(30),topRight: Radius.circular(20)),
                        ),
                      ),
                    ),
                  )
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height*0.30,
                  right: 0.0,
                  child:Col(color: Colors.black,height: 18,width: 45,width1: 55,width2: 65,width3: 30,sizedB: 10,)),
              Positioned(
                  left:size.width*0.2,
                  child:Transform.translate(
                    offset:Offset(-75,-79),
                    child: Container(
                      width: 250,
                      height: 250,
                      child: Image.asset('assets/images/barg1.png',fit: BoxFit.cover,),
                    ),
                  )
              ),
              Positioned(
                top:10,
                left: 40,
                child:Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape:BoxShape.circle,
                    color:Color.fromRGBO(254, 221,106, 0.8),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child:Container(
                  height:size.width*0.5,
                  width: size.width*0.5,
                  child: Image.asset('assets/images/layer1.png',fit: BoxFit.cover,),
                ),
              ),
              Positioned(
                left: 30,
                bottom: size.width*0.24,
                child: Container(
                  width: size.width*0.7,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        textAlign: TextAlign.start,
                        text:TextSpan(
                          text:'Every \nindividual \nis unique.\n\n',
                          style:GoogleFonts.poppins(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.grey[900],letterSpacing: 1.2,height: 1.2),
                          children: [
                            TextSpan(text:'Start meditate to enhance objectivity and achieve the bravest goals\n',style:GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize:18,height: 1.5,color: Colors.grey[900])),
                          ],
                        ),
                      ),
                      Container(
                        height: size.width*0.16,
                        width: size.width*0.5,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: (){
                            Navigator.pushReplacementNamed(context,HomeScreen.id);
                          },
                          child:Text('Get Started',style: TextStyle(color: Colors.white,fontSize:22),),
                          color:Theme.of(context).textTheme.button.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}