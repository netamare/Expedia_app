import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final bool signedIn = false; // Demo only. Set true to test signed-in.

  @override
  Widget build(BuildContext context) {
    if (!signedIn) {
      return Scaffold(
        appBar: AppBar(title: Text('Account')),
        body: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.account_circle, size: 90, color: Colors.blueGrey[300]),
              SizedBox(height: 16),
              Text("Sign in or Create Account", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: 9),
              Text("Access your preferences, bookings, and offers.", textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
              SizedBox(height: 18),
              ElevatedButton(onPressed: () {}, child: Text("Sign in")),
              SizedBox(height: 9),
              OutlinedButton(onPressed: () {}, child: Text("Create Account")),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Account')),
      body: ListView(
        padding: EdgeInsets.only(top:12, left: 8, right: 8, bottom:36),
        children: [
          _blueCard(context),
          ..._accountTiles(),
        ],
      ),
    );
  }

  Widget _blueCard(BuildContext context) => Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(color: Color(0xFFF4F6FE), borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Icon(Icons.phone_android, color: Colors.blue[800], size: 34),
        title: Text("Add your mobile number"),
        subtitle: Text("Use your phone to securely sign in and get critical updates."),
        trailing: Wrap(
          children: [
            ElevatedButton(onPressed: () {}, child: Text("Add")),
            SizedBox(width: 9),
            TextButton(onPressed: () {}, child: Text("Maybe later")),
          ],
        ),
      )
  );

  List<Widget> _accountTiles() => [
    _profileTile(Icons.person, "Profile", "Provide your personal details and travel documents"),
    _profileTile(Icons.mail, "Communications", "Control which notifications you get"),
    _profileTile(Icons.credit_card, "Payment methods", "View saved payment methods"),
    _profileTile(Icons.local_offer, "Coupons", "View your available coupons"),
    _profileTile(Icons.money, "Credits", "View your active airline credits"),
    _profileTile(Icons.rate_review, "Reviews", "Read reviews you've shared"),
    _profileTile(Icons.lock, "Security and settings", "Update your email or password and change app preferences"),
    _profileTile(Icons.gavel, "Legal", "See terms, policies, and privacy"),
  ];

  Widget _profileTile(IconData icon, String label, String desc) => Card(
    margin: EdgeInsets.symmetric(vertical:6),
    child: ListTile(
      leading: Icon(icon, color: Colors.blue[700]),
      title: Text(label),
      subtitle: Text(desc),
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    ),
  );
}