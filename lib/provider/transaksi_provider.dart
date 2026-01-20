import 'package:flutter/material.dart';
import '../models/transaksi_model.dart';
import '../services/transaksi_service.dart';

class TransaksiProvider extends ChangeNotifier {
  List<TransaksiModel> _list = [];
  String _token = '';

  bool _isLoading = false;
  String _errorMessage = '';

  // Getter
  List<TransaksiModel> get list => _list;
  String get token => _token;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Set token dan langsung fetch transaksi
  void setToken(String token) {
    _token = token;
    print('Token diset: $_token'); // log token
    fetchTransaksi();
  }

  // Fetch transaksi dari API
  Future<void> fetchTransaksi() async {
    if (_token.isEmpty) return;

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final data = await TransaksiService.getTransaksi(_token);
      _list = data;
      print('Fetch transaksi berhasil, total: ${_list.length}'); // log
    } catch (e) {
      _list = [];
      _errorMessage = 'Gagal mengambil data: $e';
      print(_errorMessage); // log error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Tambah transaksi
  Future<bool> addTransaksi(TransaksiModel t) async {
    if (_token.isEmpty) {
      print('Gagal: token kosong');
      return false;
    }

    try {
      print('Mengirim transaksi: ${t.namaTransaksi}, ${t.jenis}, ${t.kategori}, ${t.total}, ${t.tanggal}');
      final success = await TransaksiService.tambahTransaksi(_token, t);
      if (success) {
        print('Transaksi berhasil ditambahkan, fetch ulang list...');
        await fetchTransaksi();
      } else {
        print('Transaksi gagal ditambahkan oleh service');
      }
      return success;
    } catch (e) {
      print('Error addTransaksi: $e');
      return false;
    }
  }

  // Update transaksi
  Future<bool> updateTransaksi(TransaksiModel t) async {
    if (_token.isEmpty) return false;

    try {
      final success = await TransaksiService.updateTransaksi(_token, t);
      if (success) await fetchTransaksi();
      return success;
    } catch (e) {
      print('Error updateTransaksi: $e');
      return false;
    }
  }

  // Hapus transaksi
  Future<bool> deleteTransaksi(int id) async {
    if (_token.isEmpty) return false;

    try {
      final success = await TransaksiService.hapusTransaksi(_token, id);
      if (success) await fetchTransaksi();
      return success;
    } catch (e) {
      print('Error deleteTransaksi: $e');
      return false;
    }
  }

  // Hitung total pemasukan
  double totalPemasukan() =>
      _list.where((t) => t.jenis.toLowerCase() == 'pemasukan')
           .fold(0.0, (sum, t) => sum + t.total);

  // Hitung total pengeluaran
  double totalPengeluaran() =>
      _list.where((t) => t.jenis.toLowerCase() == 'pengeluaran')
           .fold(0.0, (sum, t) => sum + t.total);

  // Hitung saldo
  double saldo() => totalPemasukan() - totalPengeluaran();
}
