import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/transaksi_provider.dart';

class RekapKeuangan extends StatefulWidget {
  const RekapKeuangan({super.key});

  @override
  State<RekapKeuangan> createState() => _RekapKeuanganState();
}

class _RekapKeuanganState extends State<RekapKeuangan> {
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  bool isTahunIni = false;

  final List<String> namaBulan = const [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransaksiProvider>(context, listen: false).fetchTransaksi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransaksiProvider>(
      builder: (context, provider, child) {
        /// FILTER TRANSAKSI
        final transaksi = provider.list.where((t) {
          if (isTahunIni) {
            return t.tanggal.year == selectedYear;
          } else {
            return t.tanggal.month == selectedMonth &&
                t.tanggal.year == selectedYear;
          }
        }).toList();

        /// TOTAL PEMASUKAN
        final totalPemasukan = transaksi
            .where((t) => t.jenis.toLowerCase() == 'pemasukan')
            .fold(0.0, (prev, t) => prev + t.total);

        /// TOTAL PENGELUARAN
        final totalPengeluaran = transaksi
            .where((t) => t.jenis.toLowerCase() == 'pengeluaran')
            .fold(0.0, (prev, t) => prev + t.total);

        /// REKAP PER KATEGORI
        final Map<String, double> rekapKategori = {};
        for (var t in transaksi) {
          rekapKategori[t.kategori] =
              (rekapKategori[t.kategori] ?? 0) + t.total;
        }

        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            title: const Text("Rekap Keuangan"),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                /// TOMBOL CEPAT
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.calendar_today),
                          label: const Text("Bulan Ini"),
                          onPressed: () {
                            final now = DateTime.now();
                            setState(() {
                              selectedMonth = now.month;
                              selectedYear = now.year;
                              isTahunIni = false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.event),
                          label: const Text("Tahun Ini"),
                          onPressed: () {
                            setState(() {
                              selectedYear = DateTime.now().year;
                              isTahunIni = true;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                /// INFO FILTER
                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 8),
                  child: Text(
                    isTahunIni
                        ? "Menampilkan: Tahun $selectedYear"
                        : "Menampilkan: ${namaBulan[selectedMonth - 1]} $selectedYear",
                    style:
                        const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),

                /// DROPDOWN BULAN & TAHUN
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButton<int>(
                          value: selectedMonth,
                          isExpanded: true,
                          items: List.generate(12, (i) {
                            return DropdownMenuItem(
                              value: i + 1,
                              child: Text(namaBulan[i]),
                            );
                          }),
                          onChanged: (val) {
                            setState(() {
                              selectedMonth = val!;
                              isTahunIni = false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButton<int>(
                          value: selectedYear,
                          isExpanded: true,
                          items: List.generate(5, (i) {
                            final year = DateTime.now().year - i;
                            return DropdownMenuItem(
                              value: year,
                              child: Text(year.toString()),
                            );
                          }),
                          onChanged: (val) {
                            setState(() {
                              selectedYear = val!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                _summaryCard("Total Pemasukan", totalPemasukan,
                    Icons.account_balance_wallet, Colors.green),
                _summaryCard("Total Pengeluaran", totalPengeluaran,
                    Icons.paid, Colors.red),

                const SizedBox(height: 15),

                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Rekap Per Kategori",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      Divider(),
                    ],
                  ),
                ),

                if (rekapKategori.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Tidak ada transaksi",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),

                ...rekapKategori.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: _categoryRow(
                        _iconKategori(entry.key),
                        entry.key,
                        entry.value),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  Icon _iconKategori(String kategori) {
    switch (kategori) {
      case 'Gaji':
        return const Icon(Icons.business_center, color: Colors.blueGrey);
      case 'Makanan':
        return const Icon(Icons.fastfood, color: Colors.red);
      case 'Belanja':
        return const Icon(Icons.shopping_cart, color: Colors.orange);
      case 'Transportasi':
        return const Icon(Icons.directions_bus, color: Colors.blue);
      case 'Hiburan':
        return const Icon(Icons.sports_esports, color: Colors.purple);
      default:
        return const Icon(Icons.category, color: Colors.grey);
    }
  }

  Widget _summaryCard(
      String title, double amount, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 10),
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              const Spacer(),
              Text(
                "Rp ${amount.toStringAsFixed(0)}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryRow(Icon icon, String kategori, double amount) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 10),
            Text(kategori,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 15)),
            const Spacer(),
            Text(
              "Rp ${amount.toStringAsFixed(0)}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
