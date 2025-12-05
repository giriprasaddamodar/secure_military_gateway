import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AdminDashboard extends StatefulWidget {
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final msgCtrl = TextEditingController();
  String? status;
  bool sending = false;

  void _send() async {
    if (msgCtrl.text.trim().isEmpty) {
      setState(() { status = 'Message cannot be empty'; });
      return;
    }
    setState(() { sending = true; status = null; });
    final res = await ApiService.sendMessage(msgCtrl.text.trim());
    setState(() { sending = false; status = res['message']; msgCtrl.clear(); });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ADMIN DASHBOARD')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Send Secure Message', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              controller: msgCtrl,
              maxLines: 4,
              decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Enter secure message'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: sending ? null : _send,
              child: sending ? CircularProgressIndicator(color: Colors.white) : Text('Send'),
            ),
            if (status != null) Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(status!, style: TextStyle(color: Colors.green)),
            )
          ],
        ),
      ),
    );
  }
}
