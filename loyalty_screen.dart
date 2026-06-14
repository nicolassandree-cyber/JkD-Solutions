import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../providers/booking_provider.dart';

class LoyaltyScreen extends StatelessWidget {
  const LoyaltyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bp = Provider.of<BookingProvider>(context);
    final int count = bp.completedCleanings;
    final int nextMilestone = count < 4 ? 4 : (count < 8 ? 8 : 8);
    final double progress = count >= 8
        ? 1.0
        : count < 4
            ? count / 4.0
            : count / 8.0;

    String remiseLabel = "Aucune remise active";
    if (count >= 8) remiseLabel = "−20% actif 🎉";
    else if (count >= 4) remiseLabel = "−10% actif ✓";

    return Scaffold(
      appBar: AppBar(
        title: Text("Programme Fidélité", style: GoogleFonts.playfairDisplay()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Icon(Icons.star, color: JkdColors.gold, size: 60),
            const SizedBox(height: 20),
            Text(
              "$count",
              style: GoogleFonts.playfairDisplay(
                color: JkdColors.gold,
                fontSize: 72,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "prestations effectuées",
              style: TextStyle(color: JkdColors.offWhite, fontSize: 16),
            ),
            const SizedBox(height: 40),
            // Barre de progression
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 12,
                backgroundColor: JkdColors.grey,
                valueColor: const AlwaysStoppedAnimation<Color>(JkdColors.gold),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              count < 8
                  ? "${nextMilestone - count} prestation(s) avant le prochain palier"
                  : "Palier maximum atteint",
              style: const TextStyle(color: Colors.white54, fontSize: 13),
            ),
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: JkdColors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                remiseLabel,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: JkdColors.gold,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Paliers
            _palierRow("4 prestations", "−10%", count >= 4),
            const SizedBox(height: 10),
            _palierRow("8 prestations", "−20%", count >= 8),
            const Spacer(),
            // Bouton debug (à retirer en production)
            TextButton(
              onPressed: () => bp.addCleaning(),
              child: const Text(
                "+ Ajouter une prestation (test)",
                style: TextStyle(color: Colors.white30, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _palierRow(String label, String remise, bool atteint) {
    return Row(
      children: [
        Icon(
          atteint ? Icons.check_circle : Icons.radio_button_unchecked,
          color: atteint ? JkdColors.gold : Colors.white30,
        ),
        const SizedBox(width: 12),
        Text(label, style: TextStyle(color: atteint ? JkdColors.offWhite : Colors.white38)),
        const Spacer(),
        Text(
          remise,
          style: TextStyle(
            color: atteint ? JkdColors.gold : Colors.white30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
