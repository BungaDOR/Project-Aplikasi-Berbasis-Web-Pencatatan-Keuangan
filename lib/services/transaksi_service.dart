import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/transaksi_model.dart';

class TransaksiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  /// 📥 GET semua transaksi
  static Future<List<TransaksiModel>> getTransaksi() async {
    final response = await http.get(
      Uri.parse('$baseUrl/transaksi'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => TransaksiModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil data transaksi');
    }
  }

  /// ➕ POST tambah transaksi
  static Future<bool> tambahTransaksi(TransaksiModel transaksi) async {
    final response = await http.post(
      Uri.parse('$baseUrl/transaksi'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(transaksi.toJson()),
    );

    return response.statusCode == 201 || response.statusCode == 200;
  }

  /// ✏️ PUT update transaksi
  static Future<bool> updateTransaksi(int id, TransaksiModel transaksi) async {
    final response = await http.put(
      Uri.parse('$baseUrl/transaksi/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(transaksi.toJson()),
    );

    return response.statusCode == 200;
  }

  /// 🗑 DELETE transaksi
  static Future<bool> deleteTransaksi(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/transaksi/$id'),
      headers: {'Accept': 'application/json'},
    );

    return response.statusCode == 200;
  }
}
