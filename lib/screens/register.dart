import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final authController = Get.put<Auth>(Auth());

  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  GlobalKey _formKey = GlobalKey();

  final _emailFocus = FocusNode();
  final _nameFocus = FocusNode();
  final _passwordFocus = FocusNode();

  RxBool _isLoading = false.obs;

  register() async {
    _isLoading.value = true;

    _passwordFocus.unfocus();
    _emailFocus.unfocus();
    _nameFocus.unfocus();

    final res = await authController.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());

    if (res) {
      _isLoading.value = false;
      Get.offNamed('/login');
    }
    _isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _emailFocus.unfocus();
        _nameFocus.unfocus();
        _passwordFocus.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Register',
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
                      focusNode: _nameFocus,
                      controller: _nameController,
                      decoration: InputDecoration(hintText: 'Name'),
                    ),
                    SizedBox(height: 8),
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
                                      'REGISTER',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ), 
                            )),
                      ),
                      onTap: register,
                    ),
                    Gap(20),
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed('/login');
                      },
                      child: Text('Login'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
