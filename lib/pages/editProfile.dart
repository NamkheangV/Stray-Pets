import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:stray_pet/menuBar.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class EditProfilePage extends StatefulWidget {
  final String userId;

  const EditProfilePage({super.key, required this.userId});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late String userId;

  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
  }

  Future<void> _editProfile() async {
    final url = Uri.parse('http://10.0.2.2:3000/users/${userId}');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'user_dsName': _displayNameController.text,
        'user_email': _emailController.text,
        'user_phone': _phoneController.text,
        'user_address': _addressController.text,
      }),
    );
    print(response.body);

    if (response.statusCode == 200) {
      Get.snackbar('Update You Information Successful!!', 'Profile updated',
          backgroundColor: Colors.green, colorText: Colors.white);

      await Future.delayed(const Duration(seconds: 1));
      Get.offAll(() => MyMenu(userId: userId));
    } else {
      Get.snackbar('Something went wrong!!', 'Failed to update profile',
          backgroundColor: Colors.red, colorText: Colors.white);
      throw Exception('Failed to update profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: GoogleFonts.notoSans(
            color: const Color.fromARGB(255, 48, 48, 48),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _editProfile();
              } else {
                Get.snackbar('Error', 'Please fill in fields',
                    backgroundColor: Colors.red, colorText: Colors.white);
              }
            },
            icon: const Icon(Icons.save, color: Colors.blue),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Userid
                  TextFormField(
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    initialValue: userId,
                    decoration: InputDecoration(
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Display Name
                  TextFormField(
                    controller: _displayNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'DISPLAY NAME',
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Email
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'EMAIL',
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Phone Number
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'PHONE NUMBER',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      prefixIcon: const Icon(Icons.phone),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 80,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Address
                  TextFormField(
                    controller: _addressController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'ADDRESS',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      prefixIcon: const Icon(Icons.location_on),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 80,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
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
