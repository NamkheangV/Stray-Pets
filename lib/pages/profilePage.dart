import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stray_pet/pages/loginPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stray_pet/pages/editProfile.dart';

class ProfilePage extends StatelessWidget {
  final String userId;
  final List<dynamic> _userInfo = [];

  ProfilePage({super.key, required this.userId});

  void initState() {
    initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    final response =
        await http.get(Uri.parse('https://api.example.com/users/$userId'));
    if (response.statusCode == 200) {
      _userInfo.add(response.body);
    } else {
      throw Exception('Failed to load user information');
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
              Get.to(const EditProfilePage());
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
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
              ),
              const SizedBox(
                height: 15,
              ),

              // User Name
              Text(
                userId,
                style: GoogleFonts.notoSans(
                  color: const Color.fromARGB(255, 48, 48, 48),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16,
              ),

              // User Email
              Text(
                'Email',
                style: GoogleFonts.notoSans(
                  color: const Color.fromARGB(255, 48, 48, 48),
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              // User Address
              Text(
                '1234 Main St, New York, NY 10001',
                style: GoogleFonts.notoSans(
                  color: const Color.fromARGB(255, 48, 48, 48),
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 40,
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
