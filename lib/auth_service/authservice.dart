import 'package:shared_preferences/shared_preferences.dart';

class AuthService{
 static final String _isLoggedIn = "isLoggedIn";
 static final String _token = "token";
 static Future<void>login(String token)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedIn, true);
    await prefs.setString(_token, token);
  }
 static Future<void>logout()async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedIn);
    await prefs.remove(_token);
  }
  static Future<bool>isLoggedIn()async{
    final prefs = await SharedPreferences.getInstance();
    return  prefs.getBool(_isLoggedIn)?? false;
  }
  static Future<String?>getToken()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_token);
  }
}