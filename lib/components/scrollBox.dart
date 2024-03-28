import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScrollBox extends StatefulWidget {
  final List<dynamic> _strayPets;

  const ScrollBox({Key? key, required List<dynamic> strayPets})
      : _strayPets = strayPets,
        super(key: key);

  @override
  State<ScrollBox> createState() => _ScrollBoxState();
}

class _ScrollBoxState extends State<ScrollBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: // Categories
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories Title
          Text('Categories',
              style: GoogleFonts.notoSans(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )),

          // Categories List
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < 3; i++)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color.fromARGB(255, 255, 255, 255),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 224, 224, 224),
                          blurRadius: 4,
                          spreadRadius: 2,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/icons/$i.png', width: 40),
                        const SizedBox(width: 5),
                        Text(
                            i == 0
                                ? 'All'
                                : i == 1
                                    ? 'Dog'
                                    : 'Cat',
                            style: GoogleFonts.notoSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 112, 112, 112),
                            )),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          // Adopt Pets
          Text('Adopt Pets',
              style: GoogleFonts.notoSans(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 10),

          // Pets List
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8),
            itemCount: widget._strayPets.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final strayPet = widget._strayPets[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 143, 143, 143)
                          .withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(strayPet['petImage']),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 12),
                      decoration: BoxDecoration(
                        color: strayPet['type'] == 'Dog'
                            ? Color.fromARGB(255, 192, 120, 12)
                            : Color.fromARGB(255, 88, 151, 194)
                                .withOpacity(0.85),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // pet type
                      child: Text(
                        strayPet['type'],
                        style: GoogleFonts.notoSans(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // pet name
                        Text(
                          strayPet['name'],
                          style: GoogleFonts.notoSans(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                blurRadius: 4,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                        ),

                        // like button
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border),
                          color: const Color.fromARGB(255, 192, 12, 12),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
