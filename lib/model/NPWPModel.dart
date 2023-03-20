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
    required this.status,
  });

  String message;
  String ocrDate;
  Read read;
  String status;

  factory Npwpocr.fromJson(Map<String, dynamic> json) => Npwpocr(
        message: json["message"],
        ocrDate: json["ocr_date"],
        read: Read.fromJson(json["read"]),
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
