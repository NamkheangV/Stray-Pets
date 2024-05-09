import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 48, 48, 48)),
      ),
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
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'USEREMAIL',
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
                        : value.length < 3
                            ? 'Username must be at least 3 characters'
                            : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Password
                  TextFormField(
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
                        : value.length < 6
                            ? 'Password must be at least 6 characters'
                            : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Confirm Password
                  TextFormField(
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
                        : value.length < 6
                            ? 'Password must be at least 6 characters'
                            : null,
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  // Button
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 111, 6, 6),
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
      ),
    );
  }
}
