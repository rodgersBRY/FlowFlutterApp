import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './screens/homepage.dart';
import './screens/login.dart';
import './screens/register.dart';

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
