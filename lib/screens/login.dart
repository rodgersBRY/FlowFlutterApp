import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authController = Get.put<Auth>(Auth());

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  GlobalKey _formKey = GlobalKey();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  RxBool _isLoading = false.obs;

  login() async {
    if (_emailController.text == '' || _passwordController.text == '') {
      Get.snackbar('Error', 'Enter email and password to login');
    } else {
      _emailFocus.unfocus();
      _passwordFocus.unfocus();

      _isLoading.value = true;

      final res = await authController.login(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      if (res) {
        _isLoading.value = false;
        Get.offAllNamed('/');
      }

      _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _emailFocus.unfocus();
        _passwordFocus.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 16),
            Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        focusNode: _emailFocus,
                        controller: _emailController,
                        decoration: InputDecoration(hintText: 'Email'),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        focusNode: _passwordFocus,
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(hintText: 'Password'),
                      ),
                      Gap(40),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 200,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Obx(() => Center(
                                child: _isLoading.value
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        'LOGIN',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                              )),
                        ),
                        onTap: login,
                      ),
                      Gap(20),
                      GestureDetector(
                        onTap: () {
                          Get.offAllNamed('/register');
                        },
                        child: Text('Register'),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
