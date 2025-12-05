import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8080'; // Emulator to localhost

  static Future<Map<String, dynamic>> login(String u, String p) async {
    final uri = Uri.parse('$baseUrl/api/login');
    final res = await http.post(uri, body: {'username': u, 'password': p});
    return jsonDecode(res.body);
  }

  static Future<Map<String, dynamic>> sendMessage(String msg) async {
    final uri = Uri.parse('$baseUrl/api/send');
    final res = await http.post(uri, body: {'message': msg});
    return jsonDecode(res.body);
  }

  static Future<Map<String, dynamic>> getLatestMessage() async {
    final uri = Uri.parse('$baseUrl/api/message/latest');
    final res = await http.get(uri);
    return jsonDecode(res.body);
  }
}
