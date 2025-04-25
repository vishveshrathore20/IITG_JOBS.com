import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/provider/user_provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/utils/utils.dart';
import 'package:frontend/config.dart';
import 'package:provider/provider.dart';

class AuthService {
  static Future<bool> signUpUser({
    required BuildContext context,
    required String email,
    required String mobile,
    required String password,
    required String role,
    required String name,
  }) async {
    try {
      var user = {
        'email': email,
        'mobile': mobile,
        'password': password,
        'role': role,
        'name': name,
      };

      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/auth/register'),
        body: json.encode(user),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials',
          );
        },
      );

      return true;
    } catch (e) {
      showSnackBar(context, e.toString());
      return false;
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final navigator = Navigator.of(context);

      http.Response res = await http.post(
        Uri.parse('${Constants.uri}/api/auth/login'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          // You can add logic here if needed after login
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
