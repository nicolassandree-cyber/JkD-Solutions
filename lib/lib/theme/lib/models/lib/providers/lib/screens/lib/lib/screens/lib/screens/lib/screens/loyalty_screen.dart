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
                  final double progress = count >= 8 ? 1.0 : count < 4 ? count / 4.0 : count / 8.0;
                      String remise = count >= 8 ? "−20% actif 🎉" : count >= 4 ? "−10% actif ✓" : "Aucune remise active";

                          return Scaffold(
                                appBar: AppBar(title: Text("Programme Fidélité", style: GoogleFonts.playfairDisplay())),
                                      body: Padding(
                                              padding: const EdgeInsets.all(30),
                                                      child: Column(
                                                                children: [
                                                                            const SizedBox(height: 20),
                                                                                        const Icon(Icons.star, color: JkdColors.gold, size: 60),
                                                                                                    const SizedBox(height: 20),
                                                                                                                Text("$count", style: GoogleFonts.playfairDisplay(color: JkdColors.gold, fontSize: 72, fontWeight: FontWeight.bold)),
                                                                                                                            const Text("prestations effectuées", style: TextStyle(color: JkdColors.offWhite, fontSize: 16)),
                                                                                                                                        const SizedBox(height: 40),
                                                                                                                                                    ClipRRect(
                                                                                                                                                                  borderRadius: BorderRadius.circular(8),
                                                                                                                                                                                child: LinearProgressIndicator(value: progress, minHeight: 12,
                                                                                                                                                                                                backgroundColor: JkdColors.grey,
                                                                                                                                                                                                                valueColor: const AlwaysStoppedAnimation<Color>(JkdColors.gold)),
                                                                                                                                                                                                                            ),
                                                                                                                                                                                                                                        const SizedBox(height: 30),
                                                                                                                                                                                                                                                    Container(
                                                                                                                                                                                                                                                                  width: double.infinity, padding: const EdgeInsets.all(20),
                                                                                                                                                                                                                                                                                decoration: BoxDecoration(color: JkdColors.grey, borderRadius: BorderRadius.circular(12)),
                                                                                                                                                                                                                                                                                              child: Text(remise, textAlign: TextAlign.center,
                                                                                                                                                                                                                                                                                                              style: const TextStyle(color: JkdColors.gold, fontSize: 20, fontWeight: FontWeight.bold)),
                                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                                                      const Spacer(),
                                                                                                                                                                                                                                                                                                                                                  TextButton(
                                                                                                                                                                                                                                                                                                                                                                onPressed: () => bp.addCleaning(),
                                                                                                                                                                                                                                                                                                                                                                              child: const Text("+ Ajouter prestation (test)", style: TextStyle(color: Colors.white30, fontSize: 11))),
                                                                                                                                                                                                                                                                                                                                                                                        ],
                                                                                                                                                                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                                                                                                                                                                                      ),
                                                                                                                                                                                                                                                                                                                                                                                                          );
                                                                                                                                                                                                                                                                                                                                                                                                            }
                                                                                                                                                                                                                                                                                                                                                                                                            }