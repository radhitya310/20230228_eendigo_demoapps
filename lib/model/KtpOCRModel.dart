// To parse this JSON data, do
//
//     final ktpocr = ktpocrFromJson(jsonString);

import 'dart:convert';

Ktpocr ktpocrFromJson(String str) => Ktpocr.fromJson(json.decode(str));

String ktpocrToJson(Ktpocr data) => json.encode(data.toJson());

class Ktpocr {
  Ktpocr({
    required this.date,
    required this.message,
    required this.read,
    required this.status,
  });

  String date;
  String message;
  Read read;
  String status;

  factory Ktpocr.fromJson(Map<String, dynamic> json) => Ktpocr(
        date: json["date"],
        message: json["message"],
        read: Read.fromJson(json["read"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "message": message,
        "read": read.toJson(),
        "status": status,
      };
}

class Read {
  Read({
    required this.agama,
    required this.alamat,
    required this.berlakuHingga,
    required this.golonganDarah,
    required this.isEktp,
    required this.jenisKelamin,
    required this.kecamatan,
    required this.kelurahanDesa,
    required this.kewarganegaraan,
    required this.kotaKabupaten,
    required this.nama,
    required this.nik,
    required this.pekerjaan,
    required this.provinsi,
    required this.rtRw,
    required this.statusPerkawinan,
    required this.tanggalLahir,
    required this.tempatLahir,
  });

  String agama;
  String alamat;
  String berlakuHingga;
  String golonganDarah;
  bool isEktp;
  String jenisKelamin;
  String kecamatan;
  String kelurahanDesa;
  String kewarganegaraan;
  String kotaKabupaten;
  String nama;
  String nik;
  String pekerjaan;
  String provinsi;
  String rtRw;
  String statusPerkawinan;
  String tanggalLahir;
  String tempatLahir;

  factory Read.fromJson(Map<String, dynamic> json) => Read(
        agama: json["agama"],
        alamat: json["alamat"],
        berlakuHingga: json["berlakuHingga"],
        golonganDarah: json["golonganDarah"],
        isEktp: json["is_ektp"],
        jenisKelamin: json["jenisKelamin"],
        kecamatan: json["kecamatan"],
        kelurahanDesa: json["kelurahanDesa"],
        kewarganegaraan: json["kewarganegaraan"],
        kotaKabupaten: json["kotaKabupaten"],
        nama: json["nama"],
        nik: json["nik"],
        pekerjaan: json["pekerjaan"],
        provinsi: json["provinsi"],
        rtRw: json["rtRw"],
        statusPerkawinan: json["statusPerkawinan"],
        tanggalLahir: json["tanggalLahir"],
        tempatLahir: json["tempatLahir"],
      );

  Map<String, dynamic> toJson() => {
        "agama": agama,
        "alamat": alamat,
        "berlakuHingga": berlakuHingga,
        "golonganDarah": golonganDarah,
        "is_ektp": isEktp,
        "jenisKelamin": jenisKelamin,
        "kecamatan": kecamatan,
        "kelurahanDesa": kelurahanDesa,
        "kewarganegaraan": kewarganegaraan,
        "kotaKabupaten": kotaKabupaten,
        "nama": nama,
        "nik": nik,
        "pekerjaan": pekerjaan,
        "provinsi": provinsi,
        "rtRw": rtRw,
        "statusPerkawinan": statusPerkawinan,
        "tanggalLahir": tanggalLahir,
        "tempatLahir": tempatLahir,
      };
}
