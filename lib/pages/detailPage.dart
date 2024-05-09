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

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }

  Future<void> _fetchPetDetail() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/pets/${widget.id}'));
    final data = json.decode(response.body);
    setState(() {
      _petDetail = data;
    });
  }

  Future<void> _adoptPet() async {
    // update pet status to adopted
    final response = await http.put(
      Uri.parse('http://10.0.2.2:3000/pets/${widget.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'status': true,
      }),
    );

    if (response.statusCode == 200) {
      _showSnackBar('Adopted ${_petDetail['pet_name']} successfully!');
    } else {
      _showSnackBar('Failed to adopt ${_petDetail['pet_name']}');
    }
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
                          image: NetworkImage(_petDetail['pet_img']),
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
                          _petDetail['pet_name'],
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
                      ' The ${_petDetail['pet_type']}',
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
                            child: _petDetail['pet_gender'] == 1
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
                                    ' ${_petDetail['pet_age']}',
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
                      _petDetail['pet_description'],
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'ยืนยันการรับเลี้ยง',
                            style: GoogleFonts.notoSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 48, 48, 48),
                            ),
                          ),
                          content: Text(
                              'คุณต้องการรับเลี้ยง ${_petDetail['pet_name']} ใช่หรือไม่? ',
                              style: GoogleFonts.notoSans(
                                  fontSize: 16,
                                  color:
                                      const Color.fromARGB(255, 48, 48, 48))),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('ยกเลิก',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(255, 190, 0, 0),
                                  )),
                            ),
                            TextButton(
                                onPressed: () {
                                  _adoptPet();
                                },
                                child: Text(
                                  'รับเลี้ยง',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        const Color.fromARGB(255, 71, 160, 211),
                                  ),
                                )),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 71, 160, 211),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(15),
                    fixedSize: const Size(300, 65),
                  ),
                  child: Text(
                    'ADOPT ME',
                    style: GoogleFonts.notoSans(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Chat Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(15),
                    fixedSize: const Size(55, 65),
                  ),
                  child: const Icon(
                    Icons.chat_bubble_outline,
                    size: 30,
                    color: Color.fromARGB(255, 71, 160, 211),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
