import 'package:shared_preferences/shared_preferences.dart';

class Prefs{
  static Future<bool> saveUserId(String user_id)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString('user_id',user_id);
  }
  static Future<String> loadUserId()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }
  static Future<bool> removeUserId()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.remove('user_id');
  }


  static Future<bool> saveUserName(String userName)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString('userName',userName);
  }
  static Future<String> loadUserName()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }
  static Future<bool> removeUserName()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.remove('userName');
  }
}
