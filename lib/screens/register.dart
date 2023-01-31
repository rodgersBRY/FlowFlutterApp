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
    if (_nameController.text == '' ||
        _emailController.text == '' ||
        _passwordController.text == '') {
      Get.snackbar(
          backgroundColor: Colors.grey,
          icon: Icon(Icons.error),
          'Error',
          'Fill in all the fields!');
    } else {
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
  }

  Widget _buildTextFormField({
    required String hintText,
    required FocusNode focusNode,
    required TextEditingController textController,
  }) {
    return TextFormField(
      focusNode: focusNode,
      controller: textController,
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
        _nameFocus.unfocus();
        _passwordFocus.unfocus();
      },
      child: SafeArea(
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
                  'Create New Account',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: [
                        Gap(40),
                        _buildTextFormField(
                          hintText: 'Name',
                          focusNode: _nameFocus,
                          textController: _nameController,
                        ),
                        Gap(15),
                        _buildTextFormField(
                            hintText: 'Email',
                            focusNode: _emailFocus,
                            textController: _emailController),
                        Gap(15),
                        TextFormField(
                          focusNode: _passwordFocus,
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 18),
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          validator: (val) {
                            if (val!.isEmpty) {
                              Get.snackbar("Error", "Input password");
                              return "Error";
                            }
                            return null;
                          },
                        ),
                        Gap(60),
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
                                          'Sign Up',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
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
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
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
