import 'package:firebase_auth/widgets/custom_button.dart';
import 'package:firebase_auth/widgets/custom_textfield.dart';
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _emailFocus.unfocus();
        _passwordFocus.unfocus();
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
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
                'Login',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan,
                ),
              ),
              Gap(40),
              CustomTextField(
                hintText: 'Enter Your Email',
                icon: Icons.email,
                focusNode: _emailFocus,
                textEditingController: _emailController,
              ),
              Gap(20),
              CustomTextField(
                obscureText: true,
                hintText: "Enter Your Password",
                icon: Icons.key,
                focusNode: _passwordFocus,
                textEditingController: _passwordController,
              ),
              Gap(20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Gap(30),
              Obx(() => CustomButton(
                    buttonText: _isLoading.value ? "Loading..." : 'Login',
                    onTap: login,
                  )),
              Gap(80),
              TextButton(
                onPressed: () {
                  Get.offNamed('/register');
                },
                child: Text(
                  'New User? Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
              ),
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
