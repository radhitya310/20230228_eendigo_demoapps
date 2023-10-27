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
    required this.readConfidence,
    required this.status,
  });

  String message;
  String ocrDate;
  Read read;
  ReadConfidence readConfidence;
  String status;

  factory Stnkocr.fromJson(Map<String, dynamic> json) => Stnkocr(
        message: json["message"],
        ocrDate: json["ocr_date"],
        read: Read.fromJson(json["read"]),
        readConfidence: ReadConfidence.fromJson(json["read_confidence"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "ocr_date": ocrDate,
        "read": read.toJson(),
        "read_confidence": readConfidence.toJson(),
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
class ReadConfidence {
  ReadConfidence({
    required this.alamat,
    required this.bahanBakar,
    required this.berlakuSampai,
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

  double? alamat;
  double? bahanBakar;
  double? berlakuSampai;
  double? isiSilinder;
  double? jenis;
  double? kodeLokasi;
  double? masaBerlakuPajak;
  double? merk;
  double? model;
  double? namaPemilik;
  double? nomorBpkb;
  double? nomorMesin;
  double? nomorRangka;
  double? nomorRegistrasi;
  double? nomorStnk;
  double? nomorUrutPendaftaran;
  double? tahunPembuatan;
  double? tahunRegistrasi;
  double? tipe;
  double? warna;
  double? warnaTnkb;

  factory ReadConfidence.fromJson(Map<String, dynamic> json) => ReadConfidence(
        alamat: json["alamat"]?.toDouble(),
        bahanBakar: json["bahan_bakar"]?.toDouble(),
        berlakuSampai: json["berlaku_sampai"]?.toDouble(),
        isiSilinder: json["isi_sillinder"]?.toDouble(),
        jenis: json["jenis"]?.toDouble(),
        kodeLokasi: json["kode_lokasi"]?.toDouble(),
        masaBerlakuPajak: json["masa_berlaku_pajak"]?.toDouble(),
        merk: json["merk"]?.toDouble(),
        model: json["model"]?.toDouble(),
        namaPemilik: json["nama_pemilik"]?.toDouble(),
        nomorBpkb: json["nomor_bpkb"]?.toDouble(),
        nomorMesin: json["nomor_mesin"]?.toDouble(),
        nomorRangka: json["nomor_rangka"]?.toDouble(),
        nomorRegistrasi: json["nomor_registrasi"]?.toDouble(),
        nomorStnk: json["nomor_stnk"]?.toDouble(),
        nomorUrutPendaftaran: json["nomor_urut_pendaftaran"]?.toDouble(),
        tahunPembuatan: json["tahun_pembuatan"]?.toDouble(),
        tahunRegistrasi: json["tahun_registrasi"]?.toDouble(),
        tipe: json["tipe"]?.toDouble(),
        warna: json["warna"]?.toDouble(),
        warnaTnkb: json["warna_tnkb"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "alamat": alamat,
        "bahan_bakar": bahanBakar,
        "berlaku_sampai": berlakuSampai,
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