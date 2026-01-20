import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/transaksi_model.dart';
import '../provider/transaksi_provider.dart';

class EditTransaksiPage extends StatefulWidget {
  final TransaksiModel transaksi;
  const EditTransaksiPage({super.key, required this.transaksi});

  @override
  State<EditTransaksiPage> createState() => _EditTransaksiPageState();
}

class _EditTransaksiPageState extends State<EditTransaksiPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _totalController;
  late String _jenisTransaksi;
  late String _kategori;
  late DateTime _tanggal;

  bool _isLoading = false;

  final List<String> kategoriList = ['Gaji', 'Makanan', 'Transportasi', 'Belanja', 'Hiburan'];

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.transaksi.namaTransaksi);
    _totalController = TextEditingController(text: widget.transaksi.total.toString());
    _jenisTransaksi = widget.transaksi.jenis;
    _kategori = widget.transaksi.kategori;
    _tanggal = widget.transaksi.tanggal;
  }

  Future<void> _pilihTanggal() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggal,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _tanggal = picked);
  }

  Future<void> _updateTransaksi() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final t = TransaksiModel(
      id: widget.transaksi.id,
      namaTransaksi: _namaController.text,
      jenis: _jenisTransaksi,
      kategori: _kategori,
      total: double.parse(_totalController.text),
      tanggal: _tanggal,
    );

    final provider = Provider.of<TransaksiProvider>(context, listen: false);
    final success = await provider.updateTransaksi(t);

    setState(() => _isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaksi berhasil diperbarui')),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memperbarui transaksi')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3F7FD4),
        title: const Text('Edit Transaksi'),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('Nama Transaksi'),
                  TextFormField(
                    controller: _namaController,
                    validator: (val) => val == null || val.isEmpty ? 'Nama transaksi wajib diisi' : null,
                  ),
                  const SizedBox(height: 16),
                  _label('Jenis Transaksi'),
                  Row(
                    children: [
                      _radio('pemasukan', 'Pemasukan'),
                      const SizedBox(width: 20),
                      _radio('pengeluaran', 'Pengeluaran'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _label('Kategori'),
                  DropdownButtonFormField<String>(
                    value: _kategori,
                    items: kategoriList
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) => setState(() => _kategori = val!),
                  ),
                  const SizedBox(height: 16),
                  _label('Total'),
                  TextFormField(
                    controller: _totalController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(prefixText: 'Rp '),
                    validator: (val) => val == null || val.isEmpty ? 'Total wajib diisi' : null,
                  ),
                  const SizedBox(height: 16),
                  _label('Tanggal'),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(DateFormat('dd-MM-yyyy').format(_tanggal)),
                    trailing: const Icon(Icons.calendar_month),
                    onTap: _pilihTanggal,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _updateTransaksi,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Simpan Perubahan'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Text(text, style: const TextStyle(fontWeight: FontWeight.bold));

  Widget _radio(String value, String label) => Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: _jenisTransaksi,
            onChanged: (val) => setState(() => _jenisTransaksi = val!),
          ),
          Text(label),
        ],
      );
}