import 'package:flutter/material.dart';
import '../services/api_service.dart';

class OfficerDashboard extends StatefulWidget {
  @override
  State<OfficerDashboard> createState() => _OfficerDashboardState();
}

class _OfficerDashboardState extends State<OfficerDashboard> {
  bool loading = false;
  String? error;

  void _viewLatest() async {
    setState(() { loading = true; error = null; });
    final res = await ApiService.getLatestMessage();
    setState(() { loading = false; });
    if (res['status'] == 'ok') {
      Navigator.pushNamed(context, '/view', arguments: res['message']);
    } else {
      setState(() { error = res['message']; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OFFICER DASHBOARD')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('View Latest Secure Message', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: loading ? null : _viewLatest,
              child: loading ? CircularProgressIndicator(color: Colors.white) : Text('View'),
            ),
            if (error != null) Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(error!, style: TextStyle(color: Colors.red)),
            )
          ],
        ),
      ),
    );
  }
}
