import 'package:flutter/material.dart';
import '../services/api_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  String? error;
  bool loading = false;


  void _doLogin() async {
    setState(() { loading = true; error = null; });
    final res = await ApiService.login(userCtrl.text.trim(), passCtrl.text.trim());
    setState(() { loading = false; });

    if (res['status'] == 'ok') {
      if (res['role'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/admin');
      } else {
        Navigator.pushReplacementNamed(context, '/officer');
      }
    } else {
      setState(() { error = res['message'] ?? 'Login failed'; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('LOGIN')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(controller: userCtrl, decoration: InputDecoration(labelText: 'Username')),
            SizedBox(height: 10),
            TextField(controller: passCtrl, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            if (error != null) Text(error!, style: TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: loading ? null : _doLogin,
              child: loading ? CircularProgressIndicator(color: Colors.white) : Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}
