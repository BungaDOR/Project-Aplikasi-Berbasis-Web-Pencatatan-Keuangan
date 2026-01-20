import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final String baseURL = 'http://192.168.0.105:8000/api';

  // ================= REGISTER =================
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseURL/auth/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
      }),
    );
    print('STATUS CODE: ${response.statusCode}');
print('BODY: ${response.body}');


    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return {
        'status': true,
        'data': data,
      };
    } else {
      return {
        'status': false,
        'message': data['message'] ?? 'Registrasi gagal',
      };
    }
  }

  // ================= LOGIN =================
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseURL/auth/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      String token = data['token']; 
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      return {
        'status': true,
        'token': token,
        'user': data['user'],
      };
    } else {
      return {
        'status': false,
        'message': data['message'] ?? 'Login gagal',
      };
    }

  }

   // ================= LOGOUT =================
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // hapus token
  }
}
