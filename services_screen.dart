import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  static const List<Map<String, dynamic>> _tarifs = [
    {
      'type': 'Studio',
      'surface': '15–30 m²',
      'prix': 60,
      'icon': Icons.single_bed,
    },
    {
      'type': 'T2',
      'surface': '30–50 m²',
      'prix': 75,
      'icon': Icons.bed,
    },
    {
      'type': 'T3',
      'surface': '50–70 m²',
      'prix': 100,
      'icon': Icons.king_bed,
    },
    {
      'type': 'Maison',
      'surface': '70–120 m²',
      'prix': 140,
      'icon': Icons.home,
    },
  ];

  static const List<Map<String, dynamic>> _options = [
    {'label': 'Vitres', 'prix': 15},
    {'label': 'Cuisine (Four / Frigo)', 'prix': 15},
    {'label': 'Désinfection', 'prix': 15},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nos Tarifs", style: GoogleFonts.playfairDisplay()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Prestations de base"),
            const SizedBox(height: 12),
            ..._tarifs.map((t) => _tarifCard(t)),
            const SizedBox(height: 30),
            _sectionTitle("Options (+15€ chacune)"),
            const SizedBox(height: 12),
            ..._options.map((o) => _optionTile(o)),
            const SizedBox(height: 30),
            _sectionTitle("Programme Fidélité"),
            const SizedBox(height: 12),
            _fideliteCard("Après 4 prestations", "−10%"),
            const SizedBox(height: 8),
            _fideliteCard("Après 8 prestations", "−20%"),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: JkdColors.gold.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Tous nos tarifs incluent le matériel professionnel.\nZone d'intervention : Tours et agglomération (37).",
                style: TextStyle(color: JkdColors.offWhite, fontSize: 12, height: 1.6),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: JkdColors.gold,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  Widget _tarifCard(Map<String, dynamic> t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: JkdColors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(t['icon'] as IconData, color: JkdColors.gold, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t['type'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: JkdColors.offWhite,
                  ),
                ),
                Text(
                  t['surface'] as String,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            "${t['prix']} €",
            style: const TextStyle(
              color: JkdColors.gold,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionTile(Map<String, dynamic> o) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.add_circle_outline, color: JkdColors.gold, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              o['label'] as String,
              style: const TextStyle(color: JkdColors.offWhite),
            ),
          ),
          Text(
            "+${o['prix']} €",
            style: const TextStyle(color: JkdColors.gold, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _fideliteCard(String label, String remise) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: JkdColors.gold.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: JkdColors.offWhite)),
          Text(
            remise,
            style: const TextStyle(
              color: JkdColors.gold,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
