import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditTransaksiPage extends StatefulWidget {
  final String nama;
  final String jenis;
  final String kategori;
  final int total;
  final DateTime tanggal;

  const EditTransaksiPage({
    super.key,
    required this.nama,
    required this.jenis,
    required this.kategori,
    required this.total,
    required this.tanggal,
  });

  @override
  State<EditTransaksiPage> createState() => _EditTransaksiPageState();
}

class _EditTransaksiPageState extends State<EditTransaksiPage> {
  late TextEditingController _namaController;
  late TextEditingController _totalController;

  late String _jenisTransaksi;
  String? _kategori;
  late DateTime _tanggal;

  final List<String> kategoriList = [
    'Gaji',
    'Makanan',
    'Transport',
    'Belanja',
  ];

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.nama);
    _totalController =
        TextEditingController(text: widget.total.toString());
    _jenisTransaksi = widget.jenis;
    _kategori = widget.kategori;
    _tanggal = widget.tanggal;
  }

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
          'Edit Transaksi',
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
                _label('Nama Transaksi'),
                _textField(
                  controller: _namaController,
                  hint: 'Masukkan nama transaksi',
                ),

                const SizedBox(height: 16),

                _label('Jenis Transaksi'),
                Row(
                  children: [
                    _radio('Pemasukan'),
                    const SizedBox(width: 24),
                    _radio('Pengeluaran'),
                  ],
                ),

                const SizedBox(height: 16),

                _label('Kategori'),
                DropdownButtonFormField<String>(
                  value: _kategori,
                  items: kategoriList
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style:
                                const TextStyle(color: Colors.black87),
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

                _label('Tanggal Transaksi'),
                InkWell(
                  onTap: _pilihTanggal,
                  child: InputDecorator(
                    decoration: _inputDecoration(''),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('dd-MM-yyyy')
                              .format(_tanggal),
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

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF3F7FD4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, {
                        'nama': _namaController.text,
                        'jenis': _jenisTransaksi,
                        'kategori': _kategori,
                        'total':
                            int.tryParse(_totalController.text) ??
                                0,
                        'tanggal': _tanggal,
                      });
                    },
                    child: const Text(
                      'Simpan Perubahan',
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

  /// ===== Helper =====

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
        borderSide:
            const BorderSide(color: Color(0xFF3F7FD4)),
      ),
    );
  }
}
