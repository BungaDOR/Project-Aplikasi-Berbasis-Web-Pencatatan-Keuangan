import 'package:flutter/material.dart';

class DaftarTransaksi extends StatefulWidget {
  const DaftarTransaksi({super.key});

  @override
  State<DaftarTransaksi> createState() => _DaftarTransaksiState();
}

class _DaftarTransaksiState extends State<DaftarTransaksi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Transaksi"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pemasukan",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 109, 103, 103)),
            ),
            SizedBox(height: 90),
            Text("Makanan",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 109, 103, 103)),
            ),
            SizedBox(height: 90),
            Text("Transportasi",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 109, 103, 103)),
            ),
            SizedBox(height: 90),
            Text("Belanja",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 109, 103, 103)),
            ),
            // Daftar list
            // Container(
            //   height: 10,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            //   child: Text("Gaji Bulanan"),
            // ),
          ],
        ),
      ),
    );
  }
}