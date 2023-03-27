// To parse this JSON data, do
//
//     final stnkocr = stnkocrFromJson(jsonString);

import 'dart:convert';

Stnkocr stnkocrFromJson(String str) => Stnkocr.fromJson(json.decode(str));

String stnkocrToJson(Stnkocr data) => json.encode(data.toJson());

class Stnkocr {
  Stnkocr({
    required this.message,
    required this.ocrDate,
    required this.read,
    required this.status,
  });

  String message;
  String ocrDate;
  Read read;
  String status;

  factory Stnkocr.fromJson(Map<String, dynamic> json) => Stnkocr(
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
    required this.bahanBakar,
    required this.berlakuSampai,
    required this.isPajakAktif,
    required this.isiSilinder,
    required this.jenis,
    required this.kodeLokasi,
    required this.masaBerlakuPajak,
    required this.merk,
    required this.model,
    required this.namaPemilik,
    required this.nomorBpkb,
    required this.nomorMesin,
    required this.nomorRangka,
    required this.nomorRegistrasi,
    required this.nomorStnk,
    required this.nomorUrutPendaftaran,
    required this.tahunPembuatan,
    required this.tahunRegistrasi,
    required this.tipe,
    required this.warna,
    required this.warnaTnkb,
  });

  String alamat;
  String bahanBakar;
  String berlakuSampai;
  bool isPajakAktif;
  String isiSilinder;
  String jenis;
  String kodeLokasi;
  String masaBerlakuPajak;
  String merk;
  String model;
  String namaPemilik;
  String nomorBpkb;
  String nomorMesin;
  String nomorRangka;
  String nomorRegistrasi;
  String nomorStnk;
  String nomorUrutPendaftaran;
  String tahunPembuatan;
  String tahunRegistrasi;
  String tipe;
  String warna;
  String warnaTnkb;

  factory Read.fromJson(Map<String, dynamic> json) => Read(
        alamat: json["alamat"],
        bahanBakar: json["bahan_bakar"],
        berlakuSampai: json["berlaku_sampai"],
        isPajakAktif: json["is_pajak_aktif"],
        isiSilinder: json["isi_sillinder"],
        jenis: json["jenis"],
        kodeLokasi: json["kode_lokasi"],
        masaBerlakuPajak: json["masa_berlaku_pajak"],
        merk: json["merk"],
        model: json["model"],
        namaPemilik: json["nama_pemilik"],
        nomorBpkb: json["nomor_bpkb"],
        nomorMesin: json["nomor_mesin"],
        nomorRangka: json["nomor_rangka"],
        nomorRegistrasi: json["nomor_registrasi"],
        nomorStnk: json["nomor_stnk"],
        nomorUrutPendaftaran: json["nomor_urut_pendaftaran"],
        tahunPembuatan: json["tahun_pembuatan"],
        tahunRegistrasi: json["tahun_registrasi"],
        tipe: json["tipe"],
        warna: json["warna"],
        warnaTnkb: json["warna_tnkb"],
      );

  Map<String, dynamic> toJson() => {
        "alamat": alamat,
        "bahan_bakar": bahanBakar,
        "berlaku_sampai": berlakuSampai,
        "is_pajak_aktif": isPajakAktif,
        "isi_silinder": isiSilinder,
        "jenis": jenis,
        "kode_lokasi": kodeLokasi,
        "masa_berlaku_pajak": masaBerlakuPajak,
        "merk": merk,
        "model": model,
        "nama_pemilik": namaPemilik,
        "nomor_bpkb": nomorBpkb,
        "nomor_mesin": nomorMesin,
        "nomor_rangka": nomorRangka,
        "nomor_registrasi": nomorRegistrasi,
        "nomor_stnk": nomorStnk,
        "nomor_urut_pendaftaran": nomorUrutPendaftaran,
        "tahun_pembuatan": tahunPembuatan,
        "tahun_registrasi": tahunRegistrasi,
        "tipe": tipe,
        "warna": warna,
        "warna_tnkb": warnaTnkb,
      };
}
