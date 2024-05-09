import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:stray_pet/pages/detailPage.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
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
                    hintText: 'Search for Favorite',
                    hintStyle: GoogleFonts.notoSans(
                      fontSize: 18,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Favourite List
              Container(
                  height: 680,
                  width: double.maxFinite,
                  child: _strayPets.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 66, 170, 255),
                          ),
                        )
                      : SingleChildScrollView(
                          child: GridView.count(
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
                                  Get.to(() => DetailPage(id: strayPet['id']));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(strayPet['petImage']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                        ))),
            ],
          ),
        ),
      )),
    );
  }
}
