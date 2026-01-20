class TransaksiModel {
  final int? id;
  final String namaTransaksi;
  final String jenis;
  final String kategori;
  final double total; // pakai double
  final DateTime tanggal;

  TransaksiModel({
    this.id,
    required this.namaTransaksi,
    required this.jenis,
    required this.kategori,
    required this.total,
    required this.tanggal,
  });

  factory TransaksiModel.fromJson(Map<String, dynamic> json) {
    return TransaksiModel(
      id: json['id'],
      namaTransaksi: json['nama_transaksi'],
      jenis: json['jenis'],
      kategori: json['kategori'],
      total: double.parse(json['total'].toString()), // parse string/decimal ke double
      tanggal: DateTime.parse(json['tanggal']),
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'nama_transaksi': namaTransaksi,
        'jenis': jenis,
        'kategori': kategori,
        'total': total,
        'tanggal': tanggal.toIso8601String(),
      };
}