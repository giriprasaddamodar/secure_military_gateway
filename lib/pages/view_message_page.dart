import 'package:flutter/material.dart';

class ViewMessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final msg = ModalRoute.of(context)!.settings.arguments as String? ?? 'No message';

    return Scaffold(
      appBar: AppBar(title: Text('VIEW MESSAGE')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Received Secure Message:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Text(msg, style: TextStyle(fontSize: 16)),
            )
          ],
        ),
      ),
    );
  }
}
