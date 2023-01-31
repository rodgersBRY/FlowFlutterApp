import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/chats_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RxString username = ''.obs;
  RxInt _selectedIndex = 0.obs;

  void _switchTabs(int index) {
    _selectedIndex.value = index;
  }

  getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? name = sharedPreferences.getString('name');
    username.value = name!;
  }

  @override
  void initState() {
    getValidation().whenComplete(() async {
      Get.offNamed(username.value != '' ? '/' : '/login');
    });

    super.initState();
  }

  static List<Widget> _pages = [
    Icon(
      Icons.call,
      size: 150,
    ),
    Icon(
      Icons.camera,
      size: 150,
    ),
    ChatsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() => Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$username',
                        style: TextStyle(fontSize: 20),
                      ),
                      IconButton(
                        icon: Icon(Icons.logout),
                        onPressed: () async {
                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.remove('token');
                          sharedPreferences.remove('name');
                          sharedPreferences.remove('email');

                          Get.offNamed('/login');
                        },
                      ),
                    ],
                  ),
                  Gap(30),
                  Expanded(child: _pages.elementAt(_selectedIndex.value))
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex.value,
              onTap: _switchTabs,
              elevation: 0,
              selectedItemColor: Colors.cyan,
              unselectedItemColor: Colors.grey,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.call),
                  label: 'Calls',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.camera), label: 'Camera'),
                BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats')
              ],
            ),
          )),
    );
  }
}
