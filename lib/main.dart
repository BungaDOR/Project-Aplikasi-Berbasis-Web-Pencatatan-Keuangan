import 'package:flutter/material.dart';
import 'pages/tambah_transaksi_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      /// WAJIB: theme terang supaya text tidak putih
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF3F7FD4),
        scaffoldBackgroundColor: const Color(0xFFF2F4F8),
        useMaterial3: false,
      ),

      /// HALAMAN PERTAMA (LIST DATA DARI DB)
      home: const TambahTransaksiPage(),
    );
  }
}
