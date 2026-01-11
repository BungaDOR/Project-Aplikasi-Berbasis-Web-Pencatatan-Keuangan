import 'dart:convert';

class TransaksiModel {
  final int id;
  final int userId;
  final String nama;
  final String jenis;
  final String kategori;
  final int total;
  final DateTime tanggal;
  final DateTime createdAt;
  final DateTime updatedAt;

  TransaksiModel({
    required this.id,
    required this.userId,
    required this.nama,
    required this.jenis,
    required this.kategori,
    required this.total,
    required this.tanggal,
    required this.createdAt,
    required this.updatedAt,
  });

  // TransaksiModel copyWith({
  //   int? id,
  //   int? userId,
  //   String? nama,
  //   String? jenis,
  //   String? kategori,
  //   int? total,
  //   DateTime? tanggal,
  //   DateTime? createdAt,
  //   DateTime? updatedAt,
  // }) {
  //   return TransaksiModel(
  //     id: id ?? this.id,
  //     userId: userId ?? this.userId,
  //     nama: nama ?? this.nama,
  //     jenis: jenis ?? this.jenis,
  //     kategori: kategori ?? this.kategori,
  //     total: total ?? this.total,
  //     tanggal: tanggal ?? this.tanggal,
  //     createdAt: createdAt ?? this.createdAt,
  //     updatedAt: updatedAt ?? this.updatedAt,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'nama': nama,
      'jenis': jenis,
      'kategori': kategori,
      'total': total,
      'tanggal': tanggal.millisecondsSinceEpoch,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory TransaksiModel.fromMap(Map<String, dynamic> map) {
    return TransaksiModel(
      id: map['id']?.toInt() ?? 0,
      userId: map['userId']?.toInt() ?? 0,
      nama: map['nama'] ?? '',
      jenis: map['jenis'] ?? '',
      kategori: map['kategori'] ?? '',
      total: map['total']?.toInt() ?? 0,
      tanggal: DateTime.fromMillisecondsSinceEpoch(map['tanggal']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransaksiModel.fromJson(String source) => TransaksiModel.fromMap(json.decode(source));

  // @override
  // String toString() {
  //   return 'TransaksiModel(id: $id, userId: $userId, nama: $nama, jenis: $jenis, kategori: $kategori, total: $total, tanggal: $tanggal, createdAt: $createdAt, updatedAt: $updatedAt)';
  // }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;
  
  //   return other is TransaksiModel &&
  //     other.id == id &&
  //     other.userId == userId &&
  //     other.nama == nama &&
  //     other.jenis == jenis &&
  //     other.kategori == kategori &&
  //     other.total == total &&
  //     other.tanggal == tanggal &&
  //     other.createdAt == createdAt &&
  //     other.updatedAt == updatedAt;
  // }

  // @override
  // int get hashCode {
  //   return id.hashCode ^
  //     userId.hashCode ^
  //     nama.hashCode ^
  //     jenis.hashCode ^
  //     kategori.hashCode ^
  //     total.hashCode ^
  //     tanggal.hashCode ^
  //     createdAt.hashCode ^
  //     updatedAt.hashCode;
  // }
}
