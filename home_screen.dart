import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  // FIX: callback de navigation injecté depuis main.dart
  final void Function(int index) onNavigate;

  const HomeScreen({Key? key, required this.onNavigate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [JkdColors.black, JkdColors.grey],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("JkD Solutions", style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(height: 8),
                const Text(
                  "Conciergerie Premium · Tours",
                  style: TextStyle(
                    color: JkdColors.offWhite,
                    letterSpacing: 2,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 60),
                // FIX: navigation vers onglet 2 (Réserver)
                _homeButton(
                  context,
                  "Réserver une intervention",
                  true,
                  onTap: () => onNavigate(2),
                ),
                const SizedBox(height: 15),
                // FIX: navigation vers onglet 1 (Services/Tarifs)
                _homeButton(
                  context,
                  "Nos Tarifs",
                  false,
                  onTap: () => onNavigate(1),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: JkdColors.gold),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "À PARTIR DE 60€",
                    style: TextStyle(
                      color: JkdColors.gold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _homeButton(
    BuildContext context,
    String text,
    bool primary, {
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 280,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary ? JkdColors.gold : Colors.transparent,
          side: primary ? BorderSide.none : const BorderSide(color: JkdColors.gold),
          foregroundColor: primary ? JkdColors.black : JkdColors.gold,
        ),
        onPressed: onTap,
        child: Text(text.toUpperCase()),
      ),
    );
  }
}
