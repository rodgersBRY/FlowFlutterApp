import 'dart:convert';

import 'package:firebase_auth/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends GetxController {
  register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final resp = await http.post(
        Uri.parse('${AppConstants.SERVER_URI}/api/auth/register'),
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
        }),
        headers: {"Content-Type": "application/json"},
      );

      Map<String, dynamic> jsonData = json.decode(resp.body);

      if (resp.statusCode != 201) {
        Get.snackbar(
            backgroundColor: Colors.grey,
            icon: Icon(Icons.error),
            'Error',
            jsonData['message']);
        return false;
      }

      return true;
    } catch (err) {
      throw Exception(err);
    }
  }

  login({required String email, required String password}) async {
    try {
      final resp = await http.post(
        Uri.parse('${AppConstants.SERVER_URI}/api/auth/login'),
        body: json.encode({'email': email, 'password': password}),
        headers: {"Content-Type": "application/json"},
      );

      Map<String, dynamic> jsonData = json.decode(resp.body);

      if (resp.statusCode != 200) {
        Get.snackbar(
            backgroundColor: Colors.grey,
            icon: Icon(Icons.error),
            'Error',
            jsonData['message']);
        return false;
      }

      var username = jsonData['user']['name'];

      var token = jsonData['token'];

      // save the email in shared preferences to check for authentication
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('token', token);
      sharedPreferences.setString('email', email);
      sharedPreferences.setString('name', username);

      return true;
    } catch (err) {
      throw Exception(err);
    }
  }
}
