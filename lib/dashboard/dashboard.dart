import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_akhir_uas/page_profil/profil.dart';
import 'package:provider/provider.dart';

import '../provider/transaksi_provider.dart';
import '../models/transaksi_model.dart';
import '../daftar_transaksi/daftar_transaksi.dart';
import '../rekap_keuangan/rekap_keuangan.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransaksiProvider>(context, listen: false).fetchTransaksi();
    });
  }

  void _onNavTap(int index) {
  setState(() => _currentIndex = index);

  if (index == 1) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const DaftarTransaksi()),
    ).then((_) {
      setState(() => _currentIndex = 0);
    });
  } else if (index == 2) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RekapKeuangan()),
    ).then((_) {
      setState(() => _currentIndex = 0);
    });
  } else if (index == 3) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProfilPage()),
    ).then((_) {
      setState(() => _currentIndex = 0);
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Consumer<TransaksiProvider>(
      builder: (context, provider, child) {
        /// LIST
        final List<TransaksiModel> transaksi =
            List<TransaksiModel>.from(provider.list);

        /// URUTKAN DARI TERBARU → TERLAMA
        transaksi.sort((a, b) => b.tanggal.compareTo(a.tanggal));

        /// AMBIL 7 TERBARU
        final List<TransaksiModel> terbaru = transaksi.take(7).toList();

        final totalPemasukan = provider.totalPemasukan();
        final totalPengeluaran = provider.totalPengeluaran();
        final saldo = provider.saldo();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text(
              'Dashboard',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selamat Datang 👋',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Ringkasan Keuangan Anda',
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 16),

                /// RINGKASAN
                Row(
                  children: [
                    SummaryCard(
                      title: 'Pemasukan',
                      value: _rupiah(totalPemasukan),
                      color: Colors.green,
                    ),
                    const SizedBox(width: 8),
                    SummaryCard(
                      title: 'Pengeluaran',
                      value: _rupiah(totalPengeluaran),
                      color: Colors.red,
                    ),
                    const SizedBox(width: 8),
                    SummaryCard(
                      title: 'Saldo',
                      value: _rupiah(saldo),
                      color: Colors.blue,
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                const Text(
                  'Transaksi Terbaru',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                Expanded(
                  child: terbaru.isEmpty
                      ? const Center(
                          child: Text(
                            'Belum ada transaksi',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: terbaru.length,
                          itemBuilder: (context, index) {
                            final t = terbaru[index];
                            final isPemasukan =
                                t.jenis.toLowerCase() == 'pemasukan';

                            return Card(
                              child: ListTile(
                                leading: Icon(
                                  isPemasukan
                                      ? Icons.arrow_downward
                                      : Icons.arrow_upward,
                                  color: isPemasukan
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                title: Text(t.namaTransaksi),
                                subtitle: Text(
                                  DateFormat('dd MMM yyyy')
                                      .format(t.tanggal),
                                ),
                                trailing: Text(
                                  '${isPemasukan ? '+' : '-'} ${_rupiah(t.total)}',
                                  style: TextStyle(
                                    color: isPemasukan
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onNavTap,
            selectedItemColor: Colors.blue,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt),
                label: 'Transaksi',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart),
                label: 'Rekap',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          ),
        );
      },
    );
  }

  String _rupiah(num value) {
    final formatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(value);
  }
}

/// CARD RINGKASAN
class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}