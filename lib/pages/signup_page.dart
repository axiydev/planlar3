import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planlar/pages/home_page.dart';
import 'package:planlar/pages/signin_page.dart';
import 'package:planlar/pages/splash_page.dart';
import 'package:planlar/services/auth_service.dart';
import 'package:planlar/services/prefs_service.dart';
import 'package:planlar/services/utils_service.dart';
import 'package:planlar/widgets/custom_widget.dart';

class SignUp extends StatefulWidget {
  static const String id='signup_page';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var fullnameControll=new TextEditingController();
  var emailController=new TextEditingController();
  var passController=new TextEditingController();
  var confirmPassController=new TextEditingController();
  _doSignUp()async{
    String name=fullnameControll.text.trim();
    String email=emailController.text.trim();
    String pass=passController.text.trim();
    String confirm=confirmPassController.text.trim();
    if(name.isEmpty||email.isEmpty||pass.isEmpty||confirm.isEmpty)return;
    if(pass!=confirm){
      await Utils.showToast('check your pass');
      return null;
    };
    AuthService.signUpUser(context, name, email, pass).then((firebaseUser){
      _getFirebaseUser(firebaseUser);
    });
  }

  _getFirebaseUser(FirebaseUser firebaseUser)async{
    if(firebaseUser!=null){
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, SplashScreen.id);
      Utils.showToast('successfully saved user');
    }else{
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
            Positioned(
              child:Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(child:_fields(context, 'Name',false,fullnameControll),),
                  Flexible(child:_fields(context, 'Email',false,emailController),),
                  Flexible(child: _fields(context, 'Password',true,passController),),
                  Flexible(child: _fields(context, 'Confirm Password',true,confirmPassController),),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      width: double.infinity,
                      height: size.width*0.15,
                      child:FlatButton(
                        onPressed:_doSignUp,
                        child:Text('Sign Up',style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.white),),
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
                            Flexible(child:Text('Already have an account? ',style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w500),)),
                            Flexible(child:InkWell(child:Text('Sign In',style: GoogleFonts.poppins(fontSize: 13,color:Theme.of(context).textTheme.button.color,fontWeight: FontWeight.w500),),onTap: (){Navigator.pushReplacementNamed(context,SignIn.id);},),),
                          ],
                        ),
                      )),
                ],
              ),
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
          border: Border.all(width: 2,color:Theme.of(context).textTheme.button.color),
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
