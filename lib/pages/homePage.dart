import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:stray_pet/pages/detailPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _strayPets = [];

  @override
  void initState() {
    super.initState();
    _fetchStrayPets();
  }

  Future<void> _fetchStrayPets() async {
    final response = await http
        .get(Uri.parse('https://api.jsonbin.io/v3/b/66030db62b1b334a633bb9bf'));
    final data = json.decode(response.body);
    setState(() {
      _strayPets = data['record'];
    });
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
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: const NetworkImage(
                            'https://scontent.fbkk2-8.fna.fbcdn.net/v/t39.30808-6/239055674_4234639449953239_8489169008526590337_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeE9LYEw6KDbSQvULS0v1NppSLPJQNSG-E5Is8lA1Ib4TspFv_Q8uy8Hxievr7zy6Hm6SUoAZ2ObYQLiH2qXwB8C&_nc_ohc=rwmf0_XONh0AX9x9weR&_nc_ht=scontent.fbkk2-8.fna&oh=00_AfCxAx4ELH5srEZMmRpX1tV1jBMdxPrpAZpY3LlRwdOFAg&oe=660A31BD'),
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
                            'Suchanart',
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
                        onPressed: () {},
                        icon: const Icon(Icons.menu),
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
                    child: SingleChildScrollView(
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
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 15),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
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
                                              style: GoogleFonts.notoSans(
                                                  fontSize: 20,
                                                  color: const Color.fromARGB(
                                                      255, 112, 112, 112)))
                                        ]),
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
                                    Get.to(
                                        () => DetailPage(id: strayPet['id']));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image:
                                            NetworkImage(strayPet['petImage']),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        // Pets type
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: strayPet['type'] == 'Dog'
                                                ? const Color.fromARGB(
                                                    255, 66, 170, 255)
                                                : strayPet['type'] == 'Cat'
                                                    ? const Color.fromARGB(
                                                        255, 248, 143, 5)
                                                    : const Color.fromARGB(
                                                        255, 108, 211, 67),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            strayPet['type'],
                                            style: GoogleFonts.notoSans(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ),
                                        const Spacer(),

                                        // Pets Name
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween, // Align text and icon
                                          children: [
                                            Text(
                                              strayPet['name'],
                                              style: GoogleFonts.notoSans(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                shadows: [
                                                  const Shadow(
                                                      color: Colors.black,
                                                      offset: Offset(2, 2),
                                                      blurRadius: 4)
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              padding: EdgeInsets.zero,
                                              visualDensity:
                                                  VisualDensity.compact,
                                              icon: const Icon(
                                                  Icons.favorite_border),
                                              color: Colors.red,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
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
