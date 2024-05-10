import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:stray_pet/pages/loginPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> _register() async {
    final url = Uri.parse('http://10.0.2.2:3000/users');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'user_id': _usernameController.text,
          'user_email': _emailController.text,
          'user_password': _passwordController.text,
        },
      ),
    );

    // Check password match
    if (_passwordController.text != _confirmPasswordController.text) {
      Get.snackbar('Something went wrong!!', 'Password does not match',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    } else if (response.statusCode == 400) {
      Get.snackbar('Something went wrong!!', 'Username already exists',
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    } else if (response.statusCode == 201) {
      Get.snackbar('Register Successful!!', 'Register successful!!',
          backgroundColor: Colors.green, colorText: Colors.white);

      await Future.delayed(const Duration(seconds: 2));
      Get.offAll(() => const LoginPage());
    } else {
      Get.snackbar('Something went wrong!!', 'Failed to register',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: GoogleFonts.notoSans(
            color: const Color.fromARGB(255, 48, 48, 48),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 48, 48, 48)),
      ),
      body: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.only(top: 25),
          width: double.maxFinite,
          height: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                const Image(
                  image: AssetImage('assets/images/register-logo.png'),
                  width: 150,
                ),
                const SizedBox(
                  height: 35,
                ),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'USER E-MAIL',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          prefixIcon: const Icon(Icons.email),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 80,
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter your email'
                            : !value.contains('@')
                                ? 'Email is invalid'
                                : null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // Username
                      TextFormField(
                        controller: _usernameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'USERNAME',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          prefixIcon: const Icon(Icons.person),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 80,
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter your username'
                            : value.length < 6
                                ? 'Username must be at least 6 characters'
                                : null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // Password
                      TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'PASSWORD',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          prefixIcon: const Icon(Icons.lock),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 80,
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please enter your password'
                            : value.length < 4
                                ? 'Password must be at least 4 characters'
                                : null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // Confirm Password
                      TextFormField(
                        controller: _confirmPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'CONFIRM PASSWORD',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          prefixIcon: const Icon(Icons.lock),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 80,
                          ),
                        ),
                        validator: (value) => value!.isEmpty
                            ? 'Please confirm your password'
                            : value.length < 4
                                ? 'Password must be at least 4 characters'
                                : null,
                      ),
                      const SizedBox(
                        height: 40,
                      ),

                      // Button
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _register();
                          } else {
                            Get.snackbar('Something went wrong!!',
                                'Please check your input',
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          minimumSize: const Size(double.maxFinite, 60),
                          shadowColor: Colors.black,
                          elevation: 8,
                        ),
                        child: const Text(
                          'CONFIRM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
