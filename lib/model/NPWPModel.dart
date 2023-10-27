// To parse this JSON data, do
//
//     final npwpocr = npwpocrFromJson(jsonString);

import 'dart:convert';

Npwpocr npwpocrFromJson(String str) => Npwpocr.fromJson(json.decode(str));

String npwpocrToJson(Npwpocr data) => json.encode(data.toJson());

class Npwpocr {
  Npwpocr({
    required this.message,
    required this.ocrDate,
    required this.read,
    required this.readConfidence,
    required this.status,
  });

  String message;
  String ocrDate;
  Read read;
  Read2 readConfidence;
  String status;

  factory Npwpocr.fromJson(Map<String, dynamic> json) => Npwpocr(
        message: json["message"],
        ocrDate: json["ocr_date"],
        read: Read.fromJson(json["read"]),
        readConfidence: Read2.fromJson(json["read_confidence"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "ocr_date": ocrDate,
        "read": read.toJson(),
        "status": status,
      };
}

class Read {
  Read({
    required this.alamat,
    required this.kpp,
    required this.nama,
    required this.nik,
    required this.noNpwp,
  });

  String alamat;
  String kpp;
  String nama;
  String nik;
  String noNpwp;

  factory Read.fromJson(Map<String, dynamic> json) => Read(
        alamat: json["alamat"],
        kpp: json["kpp"],
        nama: json["nama"],
        nik: json["nik"],
        noNpwp: json["noNpwp"],
      );

  Map<String, dynamic> toJson() => {
        "alamat": alamat,
        "kpp": kpp,
        "nama": nama,
        "nik": nik,
        "noNpwp": noNpwp,
      };
}

class Read2 {
  Read2({
    required this.alamat,
    required this.kpp,
    required this.nama,
    required this.nik,
    required this.noNpwp,
  });

  double alamat;
  double kpp;
  double nama;
  double nik;
  double noNpwp;

  factory Read2.fromJson(Map<String, dynamic> json) => Read2(
        alamat: json["alamat"]?.toDouble(),
        kpp: json["kpp"]?.toDouble(),
        nama: json["nama"]?.toDouble(),
        nik: json["nik"]?.toDouble(),
        noNpwp: json["noNpwp"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "alamat": alamat,
        "kpp": kpp,
        "nama": nama,
        "nik": nik,
        "noNpwp": noNpwp,
      };
}
