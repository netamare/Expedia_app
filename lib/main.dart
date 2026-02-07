import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/app_theme.dart';
import 'constants/strings.dart';

// services
import 'services/hotel_service.dart';
import 'services/flight_service.dart';
import 'services/car_service.dart';
import 'services/auth_service.dart';
import 'services/search_history_service.dart';
import 'services/price_alert_service.dart';
import 'services/recommendation_service.dart';

// viewmodels
import 'screens/home/home_view_model.dart';

// screens
import 'screens/home/home_screen.dart';
import 'screens/search/search_screen.dart';
import 'screens/trips/trips_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/flight/flight_list_screen.dart';
import 'screens/hotel/hotel_list_screen.dart';
import 'screens/deals/deals_screen.dart';
import 'screens/search/car_search_screen.dart';
import 'screens/flight/flight_search_screen.dart';
import 'screens/stays/stays_search_screen.dart';

void main() {
  runApp(ExpediaApp());
}

class ExpediaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // core app services (singletons)
        Provider<HotelService>(create: (_) => HotelService()),
        Provider<FlightService>(create: (_) => FlightService()),
        Provider<CarService>(create: (_) => CarService()),
        Provider<AuthService>(create: (_) => AuthService()),

        // smart services
        Provider<SearchHistoryService>(create: (_) => SearchHistoryService()),
        Provider<PriceAlertService>(create: (_) => PriceAlertService()),
        Provider<RecommendationService>(create: (_) => RecommendationService()),

        // viewmodels
        ChangeNotifierProvider<HomeViewModel>(
          create: (ctx) => HomeViewModel(ctx.read<HotelService>()),
        ),
      ],
      child: MaterialApp(
        title: Strings.appName,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: MainShell(),
        routes: {
          '/search': (_) => SearchScreen(),
          '/trips': (_) => TripsScreen(),
          '/profile': (_) => ProfileScreen(),
          '/flights': (_) => FlightListScreen(),
          '/flight_search': (_) => FlightSearchScreen(),
          '/hotels': (_) => HotelListScreen(),
          '/deals': (_) => DealsScreen(),
          '/cars': (_) => CarSearchScreen(),       // <<-- ensure /cars exists
          '/stays': (_) => StaysSearchScreen(),
        },
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  @override
  _MainShellState createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    SearchScreen(),
    TripsScreen(),
    Scaffold(appBar: AppBar(title: Text('Inbox')), body: Center(child: Text('Inbox (demo)'))),
    ProfileScreen(),
  ];

  void _onTap(int idx) => setState(() => _currentIndex = idx);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: 'Trips'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Account'),
        ],
      ),
    );
  }
}