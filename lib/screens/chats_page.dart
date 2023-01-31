import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatsPage extends StatefulWidget {
  ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  RxString name = ''.obs;

  setName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('name');
    name.value = username!;
  }

  @override
  void initState() {
    setName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
