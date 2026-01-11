import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TambahTransaksiPage extends StatefulWidget {
  const TambahTransaksiPage({super.key});

  @override
  State<TambahTransaksiPage> createState() => _TambahTransaksiPageState();
}

class _TambahTransaksiPageState extends State<TambahTransaksiPage> {
  final _namaController = TextEditingController();
  final _totalController = TextEditingController();

  String _jenisTransaksi = 'Pemasukan';
  String? _kategori;
  DateTime _tanggal = DateTime.now();

  final List<String> kategoriList = [
    'Gaji',
    'Makanan',
    'Transport',
    'Belanja',
  ];

  Future<void> _pilihTanggal() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggal,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _tanggal = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3F7FD4),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Tambah Transaksi',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Nama Transaksi
                _label('Nama Transaksi'),
                _textField(
                  controller: _namaController,
                  hint: 'Masukkan nama transaksi',
                ),

                const SizedBox(height: 16),

                /// Jenis Transaksi
                _label('Jenis Transaksi'),
                Row(
                  children: [
                    _radio('Pemasukan'),
                    const SizedBox(width: 24),
                    _radio('Pengeluaran'),
                  ],
                ),

                const SizedBox(height: 16),

                /// Kategori
                _label('Kategori'),
                DropdownButtonFormField<String>(
                  value: _kategori,
                  items: kategoriList
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _kategori = value;
                    });
                  },
                  decoration: _inputDecoration('Pilih Kategori'),
                ),

                const SizedBox(height: 16),

                /// Total Transaksi
                _label('Total Transaksi'),
                TextFormField(
                  controller: _totalController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black87),
                  decoration: _inputDecoration('Masukkan nominal').copyWith(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Rp',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// Tanggal Transaksi
                _label('Tanggal Transaksi'),
                InkWell(
                  onTap: _pilihTanggal,
                  child: InputDecorator(
                    decoration: _inputDecoration(''),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('dd-MM-yyyy').format(_tanggal),
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                        const Icon(Icons.calendar_month,
                            color: Color(0xFF3F7FD4)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                /// Button Simpan
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3F7FD4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ===== Widget Helper =====

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black87),
      decoration: _inputDecoration(hint),
    );
  }

  Widget _radio(String value) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: _jenisTransaksi,
          activeColor: const Color(0xFF3F7FD4),
          onChanged: (val) {
            setState(() {
              _jenisTransaksi = val!;
            });
          },
        ),
        Text(
          value,
          style: const TextStyle(color: Colors.black87),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF3F7FD4)),
      ),
    );
  }
}
