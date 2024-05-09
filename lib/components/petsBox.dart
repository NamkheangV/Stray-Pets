import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PetsBox extends StatelessWidget {
  final Map<String, dynamic> strayPet;

  const PetsBox({super.key, required this.strayPet});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(strayPet['pet_img']),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Pets type
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
              color: strayPet['pet_type'] == 'Dog'
                  ? const Color.fromARGB(255, 66, 170, 255)
                  : strayPet['pet_type'] == 'Cat'
                      ? const Color.fromARGB(255, 248, 143, 5)
                      : const Color.fromARGB(255, 108, 211, 67),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              strayPet['pet_type'],
              style: GoogleFonts.notoSans(fontSize: 18, color: Colors.white),
            ),
          ),
          const Spacer(),

          // Pets Name
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Align text and icon
            children: [
              Text(
                strayPet['pet_name'],
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
                visualDensity: VisualDensity.compact,
                icon: const Icon(Icons.favorite_border),
                color: Colors.red,
              ),
            ],
          )
        ],
      ),
    );
  }
}
