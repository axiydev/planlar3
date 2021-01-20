import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planlar/pages/home_page.dart';
import 'package:planlar/pages/signup_page.dart';
import 'package:planlar/constants/constants.dart';
import 'package:planlar/pages/splash_page.dart';
import 'package:planlar/services/auth_service.dart';
import 'package:planlar/services/prefs_service.dart';
import 'package:planlar/services/utils_service.dart';
import 'package:planlar/widgets/custom_widget.dart';

class SignIn extends StatefulWidget {
  static const String id='signin_page';
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var emailController=new TextEditingController();
  var passwordController=new TextEditingController();
  _doSignIn()async{
    String email=emailController.text.trim();
    String pass=passwordController.text.trim();
    if(email.isEmpty||pass.isEmpty) return;
    AuthService.signInUser(context, email, pass).then((firebaseUser){
      _getFirebaseUser(firebaseUser);
    });
  }
  _getFirebaseUser(FirebaseUser firebaseUser)async{
    if(firebaseUser!=null){
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context,SplashScreen.id);
      Utils.showToast('Successfully sign in');
    }else if(firebaseUser==null){
      Utils.showToast('check your informations');
    }

  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child:Stack(
          children: [
            Positioned(
                top: 0.0,
                left: 0.0,
                child:Transform.translate(
                    offset:Offset(0,-size.width*0.17),
                    child:Container(
                  height: size.width*0.4,
                  width: size.width*0.4,
                  child: Image.asset('assets/images/barg1.png',fit: BoxFit.cover,),
                ),
                ),
            ),
            Positioned(
              right: 0.0,
              bottom:0.0,
              child:Col(color: Colors.grey[700],height: 20,width: size.width*0.12,width1: size.width*0.15,width2: size.width*0.2,width3: size.width*0.09,sizedB: size.width*0.02,),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(child:_fields(context, 'Email', false,emailController)),
                  Flexible(child: _fields(context, 'Password', true,passwordController),),
                  Flexible(child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    height: size.width*0.15,
                    child:FlatButton(
                      onPressed: _doSignIn,
                      child:Text('Sign In',style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.white),),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color:Theme.of(context).textTheme.button.color,
                    ),
                  ),),
                  Flexible(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: double.infinity,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(child:Text('Don\'t have an account? ',style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500),)),
                            Flexible(child:InkWell(child:Text('Sign Up',style: GoogleFonts.poppins(fontSize: 14,color:Color.fromRGBO(8,31, 34,1),fontWeight: FontWeight.w500),),onTap: (){Navigator.pushNamed(context,SignUp.id);},),),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _fields(BuildContext context,title,obs,controller){
    final Size size=MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: size.width*0.15,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 2,color: Theme.of(context).textTheme.button.color),
        ),
        child:Center(
          child: TextField(
            controller: controller,
            obscureText: obs,
            style:GoogleFonts.poppins(fontSize: 20,color: Colors.grey[700],fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: title,
              hintStyle: GoogleFonts.poppins(fontSize: 20,color: Colors.grey[700],fontWeight: FontWeight.w500),
              border:InputBorder.none,
            ),
          ),
        )
    );
  }
}
