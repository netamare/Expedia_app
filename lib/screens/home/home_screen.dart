import 'package:expedia_app/screens/search/car_search_screen.dart';
import 'package:flutter/material.dart';
import '../flight/expedia_flight_search_tab.dart';
import '../stays/stays_search_widget.dart';
// import '../search/car_search_widget.dart';
import '../packages/packages_search_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Color(0xFF266CFF),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Icon(Icons.flight_takeoff, color: Colors.yellow[700], size: 29),
              SizedBox(width: 6),
              Text("Expedia", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19, color: Colors.white)),
              Spacer(),
              Container(
                decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                child: Text("Blue", style: TextStyle(color: Color(0xFF266CFF), fontWeight: FontWeight.bold)),
              ),
              SizedBox(width: 10),
              Text("\$15.00 in OneKeyCash", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        TabBar(
          controller: _tabController,
          indicatorColor: Color(0xFF266CFF),
          indicatorWeight: 3,
          labelColor: Color(0xFF266CFF),
          unselectedLabelColor: Colors.black87,
          tabs: [
            Tab(icon: Icon(Icons.bed), text: "Stays"),
            Tab(icon: Icon(Icons.flight), text: "Flights"),
            Tab(icon: Icon(Icons.directions_car), text: "Cars"),
            Tab(icon: Icon(Icons.card_travel), text: "Packages"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              StaysSearchWidget(),
              ExpediaFlightSearchTab(),
              CarSearchScreen(),
              PackagesSearchWidget(),
            ],
          ),
        ),
      ],
    );
  }
}