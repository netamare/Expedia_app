import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../utils/validators.dart';

class LoginScreen extends StatefulWidget {
  final AuthService authService;
  const LoginScreen({required this.authService});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  String _error = '';

  Future<void> _submit() async {
    setState(() { _error = ''; _loading = true; });
    if (!isEmail(_email.text)) {
      setState(() { _error = 'Enter a valid email'; _loading = false; });
      return;
    }
    try {
      await widget.authService.login(email: _email.text, password: _password.text);
      Navigator.pop(context);
    } catch (e) {
      setState(() { _error = 'Login failed'; });
    } finally {
      setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: _email, decoration: InputDecoration(labelText: 'Email')),
          TextField(controller: _password, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
          SizedBox(height: 12),
          if (_error.isNotEmpty) Text(_error, style: TextStyle(color: Colors.red)),
          SizedBox(height: 12),
          ElevatedButton(onPressed: _loading ? null : _submit, child: _loading ? CircularProgressIndicator(color: Colors.white) : Text('Login'))
        ]),
      ),
    );
  }
}