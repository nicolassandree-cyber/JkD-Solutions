import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'theme/app_theme.dart';
import 'providers/booking_provider.dart';
import 'screens/home_screen.dart';
import 'screens/reservation_screen.dart';
import 'screens/services_screen.dart';
import 'screens/p2p_screen.dart';
import 'screens/loyalty_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: const JkdApp(),
    ),
  );
}

class JkdApp extends StatelessWidget {
  const JkdApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JkD Solutions',
      debugShowCheckedModeBanner: false,
      theme: JkdTheme.darkTheme,
      home: const _JkdShell(),
    );
  }
}

class _JkdShell extends StatefulWidget {
  const _JkdShell({Key? key}) : super(key: key);

  @override
  State<_JkdShell> createState() => _JkdShellState();
}

class _JkdShellState extends State<_JkdShell> {
  int _currentIndex = 0;

  void _navigateTo(int index) {
    setState(() => _currentIndex = index);
  }

  // FIX: HomeScreen reçoit le callback de navigation
  late final List<Widget> _screens = [
    HomeScreen(onNavigate: _navigateTo),
    const ServicesScreen(),
    const ReservationScreen(),
    const P2PScreen(),
    const LoyaltyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: JkdColors.gold,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: JkdColors.black,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
          BottomNavigationBarItem(icon: Icon(Icons.cleaning_services), label: "Services"),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: "Réserver"),
          BottomNavigationBarItem(icon: Icon(Icons.wifi_tethering), label: "P2P"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Fidélité"),
        ],
      ),
    );
  }
}
