import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  final int id;

  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, dynamic> _petDetail = {};

  @override
  void initState() {
    super.initState();
    _fetchPetDetail();
  }

  Future<void> _fetchPetDetail() async {
    final response = await http
        .get(Uri.parse('https://api.jsonbin.io/v3/b/66030db62b1b334a633bb9bf'));
    final data = json.decode(response.body);
    setState(() {
      _petDetail = data['record'].firstWhere((element) {
        return element['id'] == widget.id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 226, 226, 226),
        appBar: AppBar(
          title: Text(
            'Pet Detail',
            style: GoogleFonts.notoSans(
              color: const Color.fromARGB(255, 48, 48, 48),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 48, 48, 48)),
        ),
        body: _petDetail.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Container(
                width: double.maxFinite,
                height: double.maxFinite,
                padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // image
                    Container(
                      width: double.maxFinite,
                      height: 380,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(_petDetail['petImage']),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // name
                    Row(
                      children: [
                        Text(
                          _petDetail['name'],
                          style: GoogleFonts.notoSans(
                            color: const Color.fromARGB(255, 48, 48, 48),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border),
                          color: Colors.red,
                          iconSize: 30,
                        ),
                      ],
                    ),

                    // type
                    Text(
                      ' The ${_petDetail['type']}',
                      style: GoogleFonts.notoSans(
                        color: const Color.fromARGB(255, 104, 104, 104),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        // gender
                        Tooltip(
                          message: 'Gender',
                          child: Container(
                            width: 45,
                            height: 45,
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: _petDetail['gender'] == 1
                                ? const Icon(
                                    Icons.male,
                                    color: Colors.blue,
                                  )
                                : const Icon(Icons.female, color: Colors.pink),
                          ),
                        ),
                        const SizedBox(width: 10),

                        // age
                        Tooltip(
                          message: 'Age',
                          child: Container(
                              width: 45,
                              height: 45,
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    ' ${_petDetail['age']}',
                                    style: GoogleFonts.notoSans(
                                      color: const Color.fromARGB(
                                          255, 104, 104, 104),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(' Y',
                                      style: GoogleFonts.notoSans(
                                        color: const Color.fromARGB(
                                            255, 104, 104, 104),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              )),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    // description
                    Text(
                      _petDetail['description'],
                      style: GoogleFonts.notoSans(
                        color: const Color.fromARGB(255, 104, 104, 104),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

        // BottomAppBar
        bottomNavigationBar: BottomAppBar(
          height: 100,
          elevation: 0,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Adopt Me Button
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Adopt Me',
                    style: GoogleFonts.notoSans(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 71, 160, 211),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(15),
                    fixedSize: const Size(300, 65),
                  ),
                ),

                // Chat Button
                ElevatedButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.chat_bubble_outline,
                    size: 30,
                    color: const Color.fromARGB(255, 71, 160, 211),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(15),
                    fixedSize: const Size(55, 65),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
