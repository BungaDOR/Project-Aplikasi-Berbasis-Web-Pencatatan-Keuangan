import 'package:flutter/material.dart';
import 'package:project_akhir_uas/provider/transaksi_provider.dart';
import 'package:provider/provider.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'dashboard/dashboard.dart';
import 'daftar_transaksi/daftar_transaksi.dart';
import 'page/tambah_transaksi_page.dart';
import 'page/edit_transaksi_page.dart';
import 'page_profil/profil.dart';
import 'rekap_keuangan/rekap_keuangan.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransaksiProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Keuangan',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/dashboard': (context) => const Dashboard(),
        '/tambah_transaksi': (context) => const TambahTransaksiPage(),
        '/daftar_transaksi': (context) => const DaftarTransaksi(),
        '/rekap_keuangan': (context) => const RekapKeuangan(),
        '/profil': (context) => const ProfilPage(),
      },
      // Untuk halaman edit, kita pakai Navigator.push dengan parameter transaksi langsung
      // Jadi tidak perlu rute statis di sini
    );
  }
}
