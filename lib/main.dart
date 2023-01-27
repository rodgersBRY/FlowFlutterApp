import 'package:firebase_auth/screens/homepage.dart';
import 'package:firebase_auth/screens/login.dart';
import 'package:firebase_auth/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Authentication',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      initialRoute: '/',
      getPages: appRoutes(),
    );
  }

  appRoutes() {
    return [
      GetPage(name: '/login', page: () => LoginPage()),
      GetPage(name: '/register', page: () => RegisterPage()),
      GetPage(name: '/', page: () => HomePage())
    ];
  }
}
