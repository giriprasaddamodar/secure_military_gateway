import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/admin_dashboard.dart';
import 'pages/officer_dashboard.dart';
import 'pages/view_message_page.dart';

void main() {
  runApp(SecureMilitaryApp());
}

class SecureMilitaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Military Gateway',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      initialRoute: '/',
      routes: {
        '/': (ctx) => LoginPage(),
        '/admin': (ctx) => AdminDashboard(),
        '/officer': (ctx) => OfficerDashboard(),
        '/view': (ctx) => ViewMessagePage(),
      },
    );
  }
}
