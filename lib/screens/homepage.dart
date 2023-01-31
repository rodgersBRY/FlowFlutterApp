import 'package:flutter/material.dart';
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

  logout() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('name');
    sharedPreferences.remove('token');
    sharedPreferences.remove('email');

    Get.offAllNamed('/login');
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
            appBar: AppBar(
              toolbarHeight: 60,
              backgroundColor: Color.fromARGB(255, 114, 140, 179),
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(7),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/profile-pic.jpg'),
                ),
              ),
              title: Obx(() => Text(
                    username.value,
                    style: TextStyle(color: Colors.white),
                  )),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    onPressed: logout,
                    icon: Icon(Icons.logout, color: Colors.white),
                  ),
                ),
              ],
            ),
            body: _pages.elementAt(_selectedIndex.value),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex.value,
              onTap: _switchTabs,
              elevation: 0,
              selectedItemColor: Color.fromARGB(255, 114, 140, 179),
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
