import 'package:flutter/material.dart';
import 'package:project_akhir_uas/page_profil/profil.dart';
import 'package:project_akhir_uas/rekap_keuangan/rekap_keuangan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RekapKeuangan(),
    );
  }
}

// COBAIN DULU
// import 'package:flutter/material.dart';
// import 'package:project_akhir_uas/authCoba/register.dart';


// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Aplikasi Flutter',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       // Halaman pertama tampil
//       home: RegisterPage(),
//     );
//   }
// }

