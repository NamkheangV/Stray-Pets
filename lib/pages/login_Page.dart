import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }

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
      Get.offAll(() => MyMenu(
            userId: data['user_id'],
          ));
      _showSnackBar(
          'Login Success!!, ${_usernameController.text}! Please wait a moment...');
    } else {
      _showSnackBar('Invalid email or password');
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
            Image(
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
                        _showSnackBar('Please enter your email and password');
                      }
                    },
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 111, 6, 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      minimumSize: const Size(double.maxFinite, 60),
                      shadowColor: Colors.black,
                      elevation: 8,
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
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Color.fromARGB(255, 111, 6, 6),
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
