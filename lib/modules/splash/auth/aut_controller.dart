import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/modules/login/login_page.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  var _isAuthenticated = false;
  UserModel? _user;

  UserModel get user => _user!;

  void setUser(BuildContext context, UserModel? user) {
    if (user != null) {
      _isAuthenticated = true;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      _isAuthenticated = false;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
  //1:04

  Future<void> saveUser(UserModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString("user", user.toJson());
    return;
  }

  Future<void> currentUser(BuildContext context, var user) async {
    final instance = await SharedPreferences.getInstance();
    final json = instance.get("user") as String;
    setUser(context, UserModel.fromJson(json));
    return;
  }
}
