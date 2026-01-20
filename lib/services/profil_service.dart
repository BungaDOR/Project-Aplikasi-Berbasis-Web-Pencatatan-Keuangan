import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfilService {
  static const String baseUrl = 'http://192.168.0.105:8000/api';

  static Future<Map<String, dynamic>> getProfile(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal memuat profil');
    }
  }
}
