import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stray_pet/pages/loginPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stray_pet/pages/editProfile.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String userId;

  var user_dsName = '';
  var user_email = '';
  var user_phone = '';
  var user_address = '';

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/users/$userId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        user_dsName = data['user_dsName'];
        user_email = data['user_email'];
        user_phone = data['user_phone'];
        user_address = data['user_address'];
      });
    } else {
      Get.snackbar('Error', 'Failed to load user information',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: GoogleFonts.notoSans(
            color: const Color.fromARGB(255, 48, 48, 48),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        // Edit Button
        actions: [
          IconButton(
            onPressed: () {
              Get.to(EditProfilePage(
                userId: userId,
              ));
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // User Avatar
              const CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
              ),
              const SizedBox(
                height: 15,
              ),

              // User Name
              Text(
                user_dsName != '' ? user_dsName : userId,
                style: GoogleFonts.notoSans(
                  color: const Color.fromARGB(255, 48, 48, 48),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16,
              ),

              // User Email
              Text(
                user_email != '' ? user_email : '[Email is private]',
                style: GoogleFonts.notoSans(
                  color: const Color.fromARGB(255, 48, 48, 48),
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              // User Address
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Color.fromARGB(255, 163, 0, 0),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    user_address != '' ? user_address : '... address ...',
                    style: GoogleFonts.notoSans(
                      color: const Color.fromARGB(255, 48, 48, 48),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),

              // Menu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Tooltip(
                    message: 'My Favourites',
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_rounded),
                      iconSize: 35,
                      color: Colors.red,
                    ),
                  ),
                  Tooltip(
                    message: 'Adopted',
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.history_rounded),
                      iconSize: 35,
                      color: Colors.blue,
                    ),
                  ),
                  Tooltip(
                    message: 'Logout',
                    child: IconButton(
                      onPressed: () {
                        Get.offAll(const LoginPage());
                      },
                      icon: const Icon(Icons.logout_rounded),
                      iconSize: 35,
                      color: Colors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
