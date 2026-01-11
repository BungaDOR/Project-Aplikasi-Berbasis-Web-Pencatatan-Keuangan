import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthServices {
  final String baseURL = 'http://10.0.2.2:8000/api/';

  Future<http.Response> register(String name, String email, String password) async {
    final url = Uri.parse(baseURL + 'auth/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    print(response.body);
    return response;
  }

  Future<http.Response> login(String email, String password) async {
    final url = Uri.parse(baseURL + 'auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    print(response.body);
    return response;
  }
}
