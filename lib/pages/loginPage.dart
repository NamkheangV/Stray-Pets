import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stray_pet/menuBar.dart';
import 'package:http/http.dart' as http;
import 'package:stray_pet/pages/registerPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final url = Uri.parse('http://10.0.2.2:3000/auth');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'user_id': _usernameController.text,
          'user_password': _passwordController.text,
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Get.snackbar('Login Successful!!', 'Login successful',
          backgroundColor: Colors.green, colorText: Colors.white);

      await Future.delayed(const Duration(seconds: 2));
      Get.offAll(() => MyMenu(
            userId: data['user_id'],
          ));
    } else {
      Get.snackbar('Something went wrong!!', 'Failed to login',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo
            const Image(
              image: AssetImage('assets/images/login-logo.png'),
              width: 150,
            ),
            const SizedBox(
              height: 60,
            ),

            // Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // ID
                  TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.emailAddress,
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
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your username' : null,
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
                        : value.length < 3
                            ? 'Password must be at least 3 characters'
                            : null,
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  // Button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _login();
                      } else {
                        Get.snackbar('Error', 'Please check your input',
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
                      'LOGIN',
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

            // Register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account? ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => const RegisterPage());
                  },
                  child: Text(
                    'Register',
                    style: GoogleFonts.notoSans(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
