import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/transaksi_model.dart';

class TransaksiService {
  static const String baseUrl = 'http://192.168.0.105:8000/api';

  // Get daftar transaksi
  static Future<List<TransaksiModel>> getTransaksi(String token) async {
    final res = await http.get(
      Uri.parse('$baseUrl/transaksi'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('getTransaksi response: ${res.statusCode} ${res.body}');

    if (res.statusCode != 200) return [];
    final data = jsonDecode(res.body)['data'] as List;
    return data.map((e) => TransaksiModel.fromJson(e)).toList();
  }

  // Tambah transaksi
  static Future<bool> tambahTransaksi(String token, TransaksiModel t) async {
    // Pastikan tanggal jadi string
    final body = t.toJson();
    body['tanggal'] = t.tanggal.toIso8601String();

    print('Mengirim transaksi: $body');

    final res = await http.post(
      Uri.parse('$baseUrl/transaksi'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    print('tambahTransaksi response: ${res.statusCode} ${res.body}');

    return res.statusCode == 200 || res.statusCode == 201;
  }

  // Update transaksi
  static Future<bool> updateTransaksi(String token, TransaksiModel t) async {
    final body = t.toJson();
    body['tanggal'] = t.tanggal.toIso8601String();

    print('Mengupdate transaksi: $body');

    final res = await http.put(
      Uri.parse('$baseUrl/transaksi/${t.id}'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    print('updateTransaksi response: ${res.statusCode} ${res.body}');

    return res.statusCode == 200;
  }

  // Hapus transaksi
  static Future<bool> hapusTransaksi(String token, int id) async {
    final res = await http.delete(
      Uri.parse('$baseUrl/transaksi/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('hapusTransaksi response: ${res.statusCode} ${res.body}');

    return res.statusCode == 200;
  }
}