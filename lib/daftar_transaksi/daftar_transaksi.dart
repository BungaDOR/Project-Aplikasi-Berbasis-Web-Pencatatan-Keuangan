import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/transaksi_model.dart';
import '../page/tambah_transaksi_page.dart';
import '../page/edit_transaksi_page.dart';
import '../provider/transaksi_provider.dart';

class DaftarTransaksi extends StatefulWidget {
  const DaftarTransaksi({super.key});

  @override
  State<DaftarTransaksi> createState() => _DaftarTransaksiState();
}

class _DaftarTransaksiState extends State<DaftarTransaksi> {
  @override
  void initState() {
    super.initState();
    // Fetch data saat halaman dibuka
    final provider = Provider.of<TransaksiProvider>(context, listen: false);
    provider.fetchTransaksi();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Transaksi'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TambahTransaksiPage()),
                );
                if (result != null && result) {
                  Provider.of<TransaksiProvider>(context, listen: false)
                      .fetchTransaksi();
                }
              },
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Semua'), 
              Tab(text: 'Pemasukan'),
              Tab(text: 'Makanan'),
              Tab(text: 'Transportasi'),
              Tab(text: 'Belanja'),
              Tab(text: 'Hiburan'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TransaksiList(),
            TransaksiList(filterJenis: 'pemasukan'),
            TransaksiList(filterKategori: 'Makanan'),
            TransaksiList(filterKategori: 'Transportasi'),
            TransaksiList(filterKategori: 'Belanja'),
            TransaksiList(filterKategori: 'Hiburan'),
          ],
        ),
      ),
    );
  }
}

class TransaksiList extends StatelessWidget {
  final String? filterJenis;
  final String? filterKategori;

  const TransaksiList({super.key, this.filterJenis, this.filterKategori});

  String formatRupiah(double value) {
    // Format double jadi mata uang rupiah
    return NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0)
        .format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransaksiProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        List<TransaksiModel> list = provider.list;

        // Filter jenis
        if (filterJenis != null) {
          list = list
              .where((e) => e.jenis.toLowerCase() == filterJenis!.toLowerCase())
              .toList();
        }

        // Filter kategori
        if (filterKategori != null) {
          list = list
              .where((e) => e.kategori.toLowerCase() == filterKategori!.toLowerCase())
              .toList();
        }

        if (list.isEmpty) {
          return const Center(child: Text('Belum ada transaksi'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: list.length,
          itemBuilder: (context, index) {
            final t = list[index];
            final isPemasukan = t.jenis.toLowerCase() == 'pemasukan';

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      isPemasukan ? Colors.green.shade100 : Colors.red.shade100,
                  child: Icon(
                    isPemasukan ? Icons.arrow_downward : Icons.arrow_upward,
                    color: isPemasukan ? Colors.green : Colors.red,
                  ),
                ),
                title: Text(t.namaTransaksi),
                subtitle: Text(DateFormat('dd-MM-yyyy').format(t.tanggal)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${isPemasukan ? '+' : '-'} Rp ${formatRupiah(t.total)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isPemasukan ? Colors.green : Colors.red,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => EditTransaksiPage(transaksi: t)),
                        );
                        if (result != null && result) provider.fetchTransaksi();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Hapus Transaksi'),
                            content: Text(
                                'Apakah kamu yakin ingin menghapus "${t.namaTransaksi}"?'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text('Batal')),
                              TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Hapus')),
                            ],
                          ),
                        );

                        if (confirm != null && confirm) {
                          await provider.deleteTransaksi(t.id!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Transaksi berhasil dihapus')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}