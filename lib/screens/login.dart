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
      Get.snackbar(
          backgroundColor: Colors.grey,
          icon: Icon(Icons.error),
          'Error',
          'Enter email and password to login');
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

  Widget _buildTextFormField({
    required String hintText,
    required FocusNode focusNode,
    required TextEditingController textController,
    required bool obscureText,
  }) {
    return TextFormField(
      focusNode: focusNode,
      controller: textController,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      style: TextStyle(color: Colors.white),
      validator: (val) {
        if (val!.isEmpty) {
          Get.snackbar("Error", "Add a $hintText");
          return "Error";
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _emailFocus.unfocus();
        _passwordFocus.unfocus();
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/register.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Log In to your Account',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan,
                ),
              ),
              Gap(40),
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildTextFormField(
                          hintText: 'Email',
                          focusNode: _emailFocus,
                          textController: _emailController,
                          obscureText: false,
                        ),
                        Gap(15),
                        _buildTextFormField(
                          hintText: 'Password',
                          focusNode: _passwordFocus,
                          textController: _passwordController,
                          obscureText: true,
                        ),
                        Gap(40),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: double.maxFinite,
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.cyan,
                              borderRadius: BorderRadius.circular(25),
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
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
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
