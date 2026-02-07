import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../utils/validators.dart';

class SignupScreen extends StatefulWidget {
  final AuthService authService;
  const SignupScreen({required this.authService});
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _email = TextEditingController();
  final _name = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  String _error = '';

  Future<void> _submit() async {
    setState(() { _error = ''; _loading = true; });
    if (!isEmail(_email.text) || !isNotEmpty(_name.text)) {
      setState(() { _error = 'Please provide valid details'; _loading = false; });
      return;
    }
    try {
      await widget.authService.signup(name: _name.text, email: _email.text, password: _password.text);
      Navigator.pop(context);
    } catch (e) {
      setState(() { _error = 'Signup failed'; });
    } finally {
      setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: _name, decoration: InputDecoration(labelText: 'Full name')),
          TextField(controller: _email, decoration: InputDecoration(labelText: 'Email')),
          TextField(controller: _password, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
          SizedBox(height: 12),
          if (_error.isNotEmpty) Text(_error, style: TextStyle(color: Colors.red)),
          SizedBox(height: 12),
          ElevatedButton(onPressed: _loading ? null : _submit, child: _loading ? CircularProgressIndicator(color: Colors.white) : Text('Create account'))
        ]),
      ),
    );
  }
}