import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:planlar/pages/signin_page.dart';
import 'package:planlar/pages/splash_page.dart';
import 'package:planlar/services/prefs_service.dart';

class AuthService{
  static final _auth=FirebaseAuth.instance;
  static Future<FirebaseUser> signInUser(BuildContext context,email,password)async{
    try{
      _auth.signInWithEmailAndPassword(email:email, password:password);
      final FirebaseUser user=await _auth.currentUser();
      return user;
    }catch(e){
      return null;
    }
  }
  static Future<FirebaseUser> signUpUser(BuildContext context,name,email,password)async{
    await Prefs.saveUserName(name);
    try{
      var authResult=await _auth.createUserWithEmailAndPassword(email:email, password:password);
      FirebaseUser user =authResult.user;
      return user;
    }catch(e){
      return null;
    }
  }
  static void signOutUser(BuildContext context)async{
    _auth.signOut();
    await Prefs.removeUserName();
    Prefs.removeUserId().then((result) =>Navigator.pushReplacementNamed(context,SignIn.id));
  }

}