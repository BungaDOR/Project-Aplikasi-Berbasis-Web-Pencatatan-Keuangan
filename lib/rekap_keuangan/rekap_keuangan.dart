import 'package:flutter/material.dart';

class RekapKeuangan extends StatefulWidget {
  const RekapKeuangan({super.key});

  @override
  State<RekapKeuangan> createState() => _RekapKeuanganState();
}

class _RekapKeuanganState extends State<RekapKeuangan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rekap Keuangan"),
      backgroundColor: Colors.blue, 
      foregroundColor: Colors.white,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
          )
        ],
      ),
    );
  }
}