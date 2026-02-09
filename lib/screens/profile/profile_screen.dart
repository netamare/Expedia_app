import 'package:flutter/material.dart';
// import '../../theme_notifier.dart';
import 'package:expedia_app/theme/theme_notifier.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Authentication / profile state (in-memory). Replace with real auth as needed.
  bool signedIn = false;
  String userName = '';
  String userEmail = '';
  String userPhone = '';
  bool isBlueMember = true;
  double oneKeyCash = 15.0;

  // Local UI theme preview (only affects this page)
  bool useDarkOnPage = false;

  // Settings
  String language = 'English';
  final languages = ['English', 'Spanish', 'French', 'German', 'Amharic'];

  // Payment methods (simple in-memory list)
  List<Map<String, String>> paymentMethods = [];

  // Mock additional travelers (simple list)
  List<Map<String, String>> travelers = [];

  // Helpers for dialogs
  final _signInFormKey = GlobalKey<FormState>();
  final _createFormKey = GlobalKey<FormState>();

  final TextEditingController _signInEmailCtrl = TextEditingController();
  final TextEditingController _signInPasswordCtrl = TextEditingController();

  final TextEditingController _createNameCtrl = TextEditingController();
  final TextEditingController _createEmailCtrl = TextEditingController();
  final TextEditingController _createPasswordCtrl = TextEditingController();

  @override
  void dispose() {
    _signInEmailCtrl.dispose();
    _signInPasswordCtrl.dispose();
    _createNameCtrl.dispose();
    _createEmailCtrl.dispose();
    _createPasswordCtrl.dispose();
    super.dispose();
  }

  // ----- Auth Flow (simple in-memory) -----
  void _showSignIn() {
    _signInEmailCtrl.text = '';
    _signInPasswordCtrl.text = '';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Sign in'),
        content: Form(
          key: _signInFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _signInEmailCtrl,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (v) => (v == null || v.isEmpty) ? 'Enter email' : null,
              ),
              TextFormField(
                controller: _signInPasswordCtrl,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (v) => (v == null || v.length < 4) ? 'Password too short' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (_signInFormKey.currentState?.validate() ?? false) {
                setState(() {
                  signedIn = true;
                  userName = _signInEmailCtrl.text.split('@').first.capitalize();
                  userEmail = _signInEmailCtrl.text;
                });
                Navigator.pop(context);
              }
            },
            child: Text('Sign in'),
          )
        ],
      ),
    );
  }

  void _showCreateAccount() {
    _createNameCtrl.text = '';
    _createEmailCtrl.text = '';
    _createPasswordCtrl.text = '';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Create account'),
        content: SingleChildScrollView(
          child: Form(
            key: _createFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _createNameCtrl,
                  decoration: InputDecoration(labelText: 'Full name'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Enter name' : null,
                ),
                TextFormField(
                  controller: _createEmailCtrl,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Enter email' : null,
                ),
                TextFormField(
                  controller: _createPasswordCtrl,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (v) => (v == null || v.length < 4) ? 'Password too short' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (_createFormKey.currentState?.validate() ?? false) {
                setState(() {
                  signedIn = true;
                  userName = _createNameCtrl.text;
                  userEmail = _createEmailCtrl.text;
                });
                Navigator.pop(context);
              }
            },
            child: Text('Create'),
          )
        ],
      ),
    );
  }

  // ----- Payment Methods -----
  void _showAddPayment() {
    final _cardNameCtrl = TextEditingController();
    final _last4Ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Add payment method'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _cardNameCtrl, decoration: InputDecoration(labelText: 'Card name (e.g., Visa)')),
            TextField(controller: _last4Ctrl, decoration: InputDecoration(labelText: 'Last 4 digits')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final name = _cardNameCtrl.text.trim();
              final last4 = _last4Ctrl.text.trim();
              if (name.isNotEmpty && last4.length == 4) {
                setState(() {
                  paymentMethods.add({'name': name, 'last4': last4});
                });
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  // ----- Payment methods screen -----
  void _openPaymentMethods() {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text('Payment methods')),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            Expanded(
              child: paymentMethods.isEmpty
                  ? Center(child: Text('No payment methods added'))
                  : ListView.separated(
                itemCount: paymentMethods.length,
                separatorBuilder: (_, __) => Divider(),
                itemBuilder: (_, i) {
                  final pm = paymentMethods[i];
                  return ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text('${pm['name']} •••• ${pm['last4']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          paymentMethods.removeAt(i);
                        });
                        // Refresh route
                        (context as Element).markNeedsBuild();
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(onPressed: _showAddPayment, icon: Icon(Icons.add), label: Text('Add payment method'))
          ]),
        ),
      );
    }));
  }

  // ----- Profile details editor -----
  void _openEditProfile() {
    final _name = TextEditingController(text: userName);
    final _email = TextEditingController(text: userEmail);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _name, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: _email, decoration: InputDecoration(labelText: 'Email')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                userName = _name.text.trim();
                userEmail = _email.text.trim();
              });
              Navigator.pop(context);
            },
            child: Text('Save'),
          )
        ],
      ),
    );
  }

  // ----- Security / settings screen (mock) -----
  void _openSecuritySettings() {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text('Security and settings')),
        body: ListView(
          padding: EdgeInsets.all(12),
          children: [
            ListTile(
              leading: Icon(Icons.lock_outline),
              title: Text('Change password'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    final oldCtrl = TextEditingController();
                    final newCtrl = TextEditingController();
                    return AlertDialog(
                      title: Text('Change password'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(controller: oldCtrl, decoration: InputDecoration(labelText: 'Old password'), obscureText: true),
                          TextField(controller: newCtrl, decoration: InputDecoration(labelText: 'New password'), obscureText: true),
                        ],
                      ),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                        ElevatedButton(onPressed: () {
                          // mock
                          Navigator.pop(context);
                        }, child: Text('Change'))
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Language'),
              subtitle: Text(language),
              onTap: () => _showLanguagePicker(),
            ),
            ListTile(
              leading: Icon(Icons.brightness_6),
              title: Text('Theme'),
              subtitle: Text(useDarkOnPage ? 'Dark (preview)' : 'Light (preview)'),
              onTap: () => setState(() => useDarkOnPage = !useDarkOnPage),
            ),
          ],
        ),
      );
    }));
  }

  void _showLanguagePicker() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Select language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.map((l) {
            return RadioListTile<String>(
              value: l,
              groupValue: language,
              title: Text(l),
              onChanged: (val) {
                setState(() => language = val ?? language);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  // ----- Add mobile (mock) -----
  void _addMobileNumber() {
    final ctrl = TextEditingController(text: userPhone);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Add mobile number'),
        content: TextField(controller: ctrl, decoration: InputDecoration(labelText: 'Mobile number')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ElevatedButton(onPressed: () {
            setState(() {
              userPhone = ctrl.text.trim();
            });
            Navigator.pop(context);
          }, child: Text('Save'))
        ],
      ),
    );
  }

  // ----- Sign out -----
  void _signOut() {
    setState(() {
      signedIn = false;
      userName = '';
      userEmail = '';
      userPhone = '';
    });
  }

  // ----- Tiles builder -----
  // Replace the old _accountTile function with this one
  Widget _accountTile(IconData icon, String title, String subtitle, {VoidCallback? onTap}) {
    final bg = useDarkOnPage ? Color(0xFF23242A) : Colors.white;
    final textColor = useDarkOnPage ? Colors.white : Colors.black87;
    final subColor = useDarkOnPage ? Colors.white70 : Colors.black54;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: useDarkOnPage ? Colors.transparent : Color(0xffE8E8ED)),
      ),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF266CFF)),
        title: Text(title, style: TextStyle(color: textColor)),
        subtitle: Text(subtitle, style: TextStyle(color: subColor)),
        trailing: Icon(Icons.chevron_right, color: useDarkOnPage ? Colors.white70 : Colors.black45),
        onTap: onTap,
      ),
    );
  }
  // ----- Signed-in header card -----
  Widget _signedInHeader() {
    final bg = useDarkOnPage ? Color(0xFF121215) : Color(0xFFF4F6FF);
    final textColor = useDarkOnPage ? Colors.white : Colors.black87;
    final subColor = useDarkOnPage ? Colors.white70 : Colors.black54;
    return Column(
      children: [
        SizedBox(height: 8),
        CircleAvatar(radius: 36, child: Icon(Icons.person, size: 40)),
        SizedBox(height: 10),
        Text('Hi, ${userName.isEmpty ? 'Traveler' : userName}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
        SizedBox(height: 4),
        Text(userEmail.isEmpty ? 'No email' : userEmail, style: TextStyle(color: subColor)),
        SizedBox(height: 12),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: Color(0xFF266CFF), borderRadius: BorderRadius.circular(6)),
                  child: Text('Blue', style: TextStyle(color: Colors.white)),
                ),
                Spacer(),
                Text('\$${oneKeyCash.toStringAsFixed(2)}', style: TextStyle(color: textColor, fontSize: 22, fontWeight: FontWeight.bold)),
              ]),
              SizedBox(height: 6),
              Text('Includes \$${oneKeyCash.toStringAsFixed(2)} in OneKeyCash expiring soon', style: TextStyle(color: subColor, fontSize: 12)),
              SizedBox(height: 10),
              GestureDetector(onTap: () {}, child: Row(children: [Icon(Icons.sync, color: Colors.blueGrey), SizedBox(width: 6), Text('View rewards activity', style: TextStyle(color: Colors.blue))])),
            ],
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }

  // ----- Signed-out header -----
  Widget _signedOutHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 28.0),
      child: Column(
        children: [
          Icon(Icons.account_circle_outlined, size: 86, color: Colors.blueGrey.shade200),
          SizedBox(height: 12),
          Text('Sign in or Create account', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          SizedBox(height: 8),
          Text('Access your preferences, bookings, and offers.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
          SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(onPressed: _showSignIn, child: Text('Sign in')),
            SizedBox(width: 12),
            OutlinedButton(onPressed: _showCreateAccount, child: Text('Create account')),
          ]),
        ],
      ),
    );
  }

  // ----- Main build -----
  @override
  Widget build(BuildContext context) {
    final scaffoldBg = useDarkOnPage ? Color(0xFF0F1113) : Colors.grey.shade100;
    final cardBg = useDarkOnPage ? Color(0xFF16171A) : Colors.white;
    final textColor = useDarkOnPage ? Colors.white : Colors.black87;

    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        backgroundColor: useDarkOnPage ? Colors.black : Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _openSecuritySettings,
            tooltip: 'Settings',
          )
        ],
      ),
      backgroundColor: scaffoldBg,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: DefaultTextStyle(
          style: TextStyle(color: textColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // header
              if (!signedIn) _signedOutHeader() else _signedInHeader(),

              // Add mobile prompt (signed-in)
              if (signedIn)
                _accountTile(Icons.phone_android, userPhone.isEmpty ? 'Add your mobile number' : 'Mobile: $userPhone',
                    'Use your phone to securely sign in and get critical updates.', onTap: _addMobileNumber),

              // Main options (signed-in) OR quick actions (signed out)
              if (signedIn) ...[
                _accountTile(Icons.person, 'Profile', 'Provide your personal details and travel documents', onTap: _openEditProfile),
                _accountTile(Icons.mail_outline, 'Communications', 'Control which notifications you get', onTap: () {}),
                _accountTile(Icons.credit_card, 'Payment methods', 'View saved payment methods', onTap: _openPaymentMethods),
                _accountTile(Icons.local_offer, 'Coupons', 'View your available coupons', onTap: () {}),
                _accountTile(Icons.monetization_on, 'Credits', 'View your active airline credits', onTap: () {}),
                _accountTile(Icons.rate_review, 'Reviews', "Read reviews you've shared", onTap: () {}),
                _accountTile(Icons.lock, 'Security and settings', 'Update your email or password and change app preferences', onTap: _openSecuritySettings),
                _accountTile(Icons.gavel, 'Legal', 'See terms, policies, and privacy', onTap: () {}),
                _accountTile(Icons.help_outline, 'Help and feedback', 'Get customer support', onTap: () {}),
                SizedBox(height: 12),
                // Additional travelers card
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Additional travelers', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text('Make booking a breeze by saving profiles of family, friends, or teammates who often travel with you.', style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 10),
                    ElevatedButton(onPressed: () {
                      // add traveler (mock)
                      setState(() {
                        travelers.add({'name': 'Traveler ${travelers.length + 1}'});
                      });
                    }, child: Text('Add additional traveler')),
                  ]),
                ),
                SizedBox(height: 16),
                TextButton(onPressed: _signOut, child: Text('Sign out', style: TextStyle(color: Colors.red))),
              ] else ...[
                // Signed out quick links (non-authenticated)
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    Text('Saved & preferences', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    TextButton.icon(onPressed: _showSignIn, icon: Icon(Icons.login), label: Text('Sign in')),
                    TextButton.icon(onPressed: _showCreateAccount, icon: Icon(Icons.person_add), label: Text('Create account')),
                  ]),
                ),
              ],

              SizedBox(height: 18),
              // Settings preview (language + theme) — these are app-wide concepts but here provided for UI and quick preview
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  ListTile(
                    leading: Icon(Icons.language, color: Color(0xFF266CFF)),
                    title: Text('Language'),
                    subtitle: Text(language),
                    onTap: _showLanguagePicker,
                    trailing: Icon(Icons.chevron_right),
                  ),
                  ListTile(
                    leading: Icon(Icons.brightness_6, color: Color(0xFF266CFF)),
                    title: Text('Theme (preview)'),
                    subtitle: Text(useDarkOnPage ? 'Dark (preview for Account page)' : 'Light (preview for Account page)'),
                    trailing: Switch(
                      value: useDarkOnPage,
                      onChanged: (v) => setState(() => useDarkOnPage = v),
                    ),
                  ),
                ]),
              ),

              SizedBox(height: 26),
            ],
          ),
        ),
      ),
    );
  }
}

/// Simple helper to capitalize a string (for signup mock)
extension StringCap on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}