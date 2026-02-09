import 'package:expedia_app/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
// import 'theme_notifier.dart'; // <- new file
// Import your screens
import 'screens/home/home_screen.dart';
import 'screens/search/search_screen.dart';
import 'screens/trips/trips_screen.dart';
import 'screens/inbox/inbox_screen.dart';
import 'screens/profile/profile_screen.dart';

void main() {
  runApp(ExpediaApp());
}

class ExpediaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, _) {
        return MaterialApp(
          title: 'Expedia',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: const Color(0xFF266CFF),
            scaffoldBackgroundColor: const Color(0xFFF7F8FF),
            appBarTheme: AppBarTheme(backgroundColor: const Color(0xFF266CFF)),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: const Color(0xFF266CFF),
            scaffoldBackgroundColor: const Color(0xFF0F1113),
            appBarTheme: AppBarTheme(backgroundColor: Colors.black),
          ),
          themeMode: currentMode,
          home: MainShell(),
          // routes: { ... }
        );
      },
    );
  }
}

class MainShell extends StatefulWidget {
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIdx = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    TripsScreen(),
    InboxScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIdx],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIdx,
        onTap: (i) => setState(() => _currentIdx = i),
        selectedItemColor: const Color(0xFF266CFF),
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.card_travel), label: "Trips"),
          BottomNavigationBarItem(icon: Icon(Icons.mail_outline), label: "Inbox"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Account"),
        ],
      ),
    );
  }
}