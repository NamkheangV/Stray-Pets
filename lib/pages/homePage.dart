import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:stray_pet/pages/detailPage.dart';
import 'package:stray_pet/components/petsBox.dart';
import 'loginPage.dart';

class HomePage extends StatefulWidget {
  final String userId;

  const HomePage({super.key, required this.userId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String userId;
  var user_dsName = '';

  List<dynamic> _strayPets = [];

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    _fetchStrayPets();
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
      });
    } else {
      Get.snackbar('Error', 'Failed to load user information',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> _fetchStrayPets() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/pets'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _strayPets = data;
      });
    } else {
      Get.snackbar('Error', 'Failed to load stray pets');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // User Info
                  Row(
                    children: [
                      // User Avatar
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage('https://i.pravatar.cc/150'),
                      ),
                      const SizedBox(width: 10),

                      //User Name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello,',
                            style: GoogleFonts.notoSans(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            user_dsName != '' ? user_dsName : userId,
                            style: GoogleFonts.notoSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),

                      // Menu Button
                      IconButton(
                        onPressed: () {
                          Get.offAll(const LoginPage());
                        },
                        icon: const Icon(Icons.logout_rounded),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Search Box
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 235, 235, 235),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.search),
                        hintText: 'Search for Pets',
                        hintStyle: GoogleFonts.notoSans(
                          fontSize: 18,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),

                  // Stray Pets
                  Container(
                    height: 600,
                    width: double.maxFinite,
                    child: _strayPets.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 66, 170, 255),
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Categories
                                Text(
                                  'CATEGORIES',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                // Categories List
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for (int i = 0; i < 4; i++)
                                        InkWell(
                                          onTap: () {},
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 15),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color.fromARGB(
                                                      255, 230, 230, 230),
                                                  blurRadius: 4,
                                                  spreadRadius: 2,
                                                  offset: Offset(2, 4),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      'assets/images/icons/$i.png',
                                                      width: 40),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                      i == 0
                                                          ? 'All'
                                                          : i == 1
                                                              ? 'Dog'
                                                              : i == 2
                                                                  ? 'Cat'
                                                                  : 'Rabbit',
                                                      style:
                                                          GoogleFonts.notoSans(
                                                              fontSize: 20,
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  112,
                                                                  112,
                                                                  112)))
                                                ]),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),

                                // Adopt Pets
                                Text(
                                  'ADOPT PETS',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),

                                // Pets List
                                GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                  childAspectRatio: 0.8,
                                  controller: ScrollController(),
                                  children: [
                                    for (final strayPet in _strayPets)
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => DetailPage(
                                              petId: strayPet['pet_id'],
                                              userId: userId));
                                        },
                                        child: PetsBox(strayPet: strayPet),
                                      ),
                                  ],
                                )
                              ],
                            ),
                          ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
