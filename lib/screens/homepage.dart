import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RxString username = ''.obs;

  getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? name = sharedPreferences.getString('name');
    username.value = name!;
  }

  @override
  void initState() {
    getValidation().whenComplete(() async {
      Timer(
        Duration(seconds: 2),
        () => Get.toNamed(username.value != '' ? '/' : '/login'),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Obx(() => Text(
                  'Welcome $username',
                  style: TextStyle(fontSize: 30),
                )),
          ),
          ElevatedButton(
            onPressed: () async {
              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.remove('token');
              sharedPreferences.remove('name');
              sharedPreferences.remove('email');
              
              Get.offNamed('/login');
            },
            child: Text(
              'LOGOUT',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
