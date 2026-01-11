import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DaftarTransaksi(),
    );
  }
}

class DaftarTransaksi extends StatelessWidget {
  const DaftarTransaksi({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6, // ⬅️ DARI 5 JADI 6
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text('Daftar Transaksi'),
          bottom: const TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Semua'),
              Tab(text: 'Pemasukan'),
              Tab(text: 'Makanan'),
              Tab(text: 'Transportasi'),
              Tab(text: 'Belanja'),
              Tab(text: 'Hiburan'), // ⬅️ TAB BARU
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TransaksiList(),
            TransaksiList(),
            TransaksiList(),
            TransaksiList(),
            TransaksiList(),
            TransaksiList(), // ⬅️ VIEW HIBURAN
          ],
        ),
      ),
    );
  }
}

class TransaksiList extends StatelessWidget {
  const TransaksiList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        CategoryTitle(title: 'Pemasukan'),
        TransaksiTile(
          icon: Icons.account_balance_wallet,
          iconColor: Colors.green,
          title: 'Gaji Bulanan',
          date: '15-01-2026',
          amount: '+ Rp 5.000.000',
          amountColor: Colors.green,
        ),

        CategoryTitle(title: 'Makanan'),
        TransaksiTile(
          icon: Icons.restaurant,
          iconColor: Colors.orange,
          title: 'Makan siang',
          date: '20-01-2026',
          amount: '- Rp 25.000',
          amountColor: Colors.red,
        ),
        TransaksiTile(
          icon: Icons.restaurant,
          iconColor: Colors.orange,
          title: 'Sarapan',
          date: '19-01-2026',
          amount: '- Rp 15.000',
          amountColor: Colors.red,
        ),

        CategoryTitle(title: 'Transportasi'),
        TransaksiTile(
          icon: Icons.directions_bus,
          iconColor: Colors.blue,
          title: 'Ojek Online',
          date: '18-01-2026',
          amount: '- Rp 15.000',
          amountColor: Colors.red,
        ),
        TransaksiTile(
          icon: Icons.train,
          iconColor: Colors.blue,
          title: 'Tiket Kereta',
          date: '10-01-2026',
          amount: '- Rp 100.000',
          amountColor: Colors.red,
        ),

        CategoryTitle(title: 'Belanja'),
        TransaksiTile(
          icon: Icons.shopping_bag,
          iconColor: Colors.amber,
          title: 'Beli Baju',
          date: '08-01-2026',
          amount: '- Rp 200.000',
          amountColor: Colors.red,
        ),
        TransaksiTile(
          icon: Icons.shopping_bag,
          iconColor: Colors.amber,
          title: 'Alat Tulis',
          date: '05-01-2026',
          amount: '- Rp 30.000',
          amountColor: Colors.red,
        ),

        // ⬇️ KATEGORI BARU: HIBURAN
        CategoryTitle(title: 'Hiburan'),
        TransaksiTile(
          icon: Icons.movie,
          iconColor: Colors.purple,
          title: 'Nonton Bioskop',
          date: '22-01-2026',
          amount: '- Rp 50.000',
          amountColor: Colors.red,
        ),
        TransaksiTile(
          icon: Icons.music_note,
          iconColor: Colors.purple,
          title: 'Langganan Musik',
          date: '01-01-2026',
          amount: '- Rp 30.000',
          amountColor: Colors.red,
        ),
      ],
    );
  }
}

class CategoryTitle extends StatelessWidget {
  final String title;

  const CategoryTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class TransaksiTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String date;
  final String amount;
  final Color amountColor;

  const TransaksiTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.date,
    required this.amount,
    required this.amountColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.15),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title, style: const TextStyle(fontSize: 15)),
        subtitle: Text(date),
        trailing: Text(
          amount,
          style: TextStyle(
            color: amountColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
