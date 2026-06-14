import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JkdColors {
  static const black = Color(0xFF0A0A0A);
    static const gold = Color(0xFFC9A84C);
      static const offWhite = Color(0xFFF5F2EC);
        static const grey = Color(0xFF2A2A2A);
        }

        class JkdTheme {
          static ThemeData darkTheme = ThemeData(
              brightness: Brightness.dark,
                  scaffoldBackgroundColor: JkdColors.black,
                      primaryColor: JkdColors.gold,
                          colorScheme: const ColorScheme.dark(
                                primary: JkdColors.gold,
                                      surface: JkdColors.black,
                                            onSurface: JkdColors.offWhite,
                                                ),
                                                    textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme).copyWith(
                                                          displayLarge: GoogleFonts.playfairDisplay(
                                                                  color: JkdColors.gold,
                                                                          fontWeight: FontWeight.bold,
                                                                                  fontSize: 32,
                                                                                        ),
                                                                                            ),
                                                                                                elevatedButtonTheme: ElevatedButtonThemeData(
                                                                                                      style: ElevatedButton.styleFrom(
                                                                                                              backgroundColor: JkdColors.gold,
                                                                                                                      foregroundColor: JkdColors.black,
                                                                                                                              textStyle: const TextStyle(fontWeight: FontWeight.bold),
                                                                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                                                                                                            ),
                                                                                                                                                ),
                                                                                                                                                  );
                                                                                                                                                  }