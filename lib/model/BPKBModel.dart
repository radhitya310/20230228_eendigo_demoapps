// To parse this JSON data, do
//
//     final bpkbocr = bpkbocrFromJson(jsonString);

import 'dart:convert';

Bpkbocr bpkbocrFromJson(String str) => Bpkbocr.fromJson(json.decode(str));

String bpkbocrToJson(Bpkbocr data) => json.encode(data.toJson());

class Bpkbocr {
  String message;
  int numOfPages;
  String ocrDate;
  Read read;
  Read2 readConfidence;
  String status;

  Bpkbocr({
    required this.message,
    required this.numOfPages,
    required this.ocrDate,
    required this.read,
    required this.readConfidence,
    required this.status,
  });

  factory Bpkbocr.fromJson(Map<String, dynamic> json) => Bpkbocr(
        message: json["message"] ?? '',
        numOfPages: json["num_of_pages"] ?? '',
        ocrDate: json["ocr_date"] ?? '',
        read: Read.fromJson(json["read"] ?? {}),
        readConfidence: Read2.fromJson(json["read_confidence"] ?? {}),
        status: json["status"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "num_of_pages": numOfPages,
        "ocr_date": ocrDate,
        "read": read.toJson(),
        // "read_confidence": Map.from(readConfidence).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "status": status,
      };
}

class Read {
  String alamat;
  String alamatEmail;
  String bahanBakar;
  String isiSilinder;
  String jenis;
  String jumlahRoda;
  String jumlahSumbu;
  String lokDikeluarkan;
  String merk;
  String model;
  String nik;
  String noBpkb;
  String nomorMesin;
  String nomorRangka;
  String nomorRegistrasi;
  String pekerjaan;
  String pemilik;
  String tahunPembuatan;
  String tglDikeluarkan;
  String type;
  String warna;

  Read({
    required this.alamat,
    required this.alamatEmail,
    required this.bahanBakar,
    required this.isiSilinder,
    required this.jenis,
    required this.jumlahRoda,
    required this.jumlahSumbu,
    required this.lokDikeluarkan,
    required this.merk,
    required this.model,
    required this.nik,
    required this.noBpkb,
    required this.nomorMesin,
    required this.nomorRangka,
    required this.nomorRegistrasi,
    required this.pekerjaan,
    required this.pemilik,
    required this.tahunPembuatan,
    required this.tglDikeluarkan,
    required this.type,
    required this.warna,
  });

  factory Read.fromJson(Map<String, dynamic> json) => Read(
        alamat: json["alamat"] ?? '',
        alamatEmail: json["alamat_email"] ?? '',
        bahanBakar: json["bahan_bakar"] ?? '',
        isiSilinder: json["isi_silinder"] ?? '',
        jenis: json["jenis"] ?? '',
        jumlahRoda: json["jumlah_roda"] ?? '',
        jumlahSumbu: json["jumlah_sumbu"] ?? '',
        lokDikeluarkan: json["lok_dikeluarkan"] ?? '',
        merk: json["merk"] ?? '',
        model: json["model"] ?? '',
        nik: json["nik"] ?? '',
        noBpkb: json["no_bpkb"] ?? '',
        nomorMesin: json["nomor_mesin"] ?? '',
        nomorRangka: json["nomor_rangka"] ?? '',
        nomorRegistrasi: json["nomor_registrasi"] ?? '',
        pekerjaan: json["pekerjaan"] ?? '',
        pemilik: json["pemilik"] ?? '',
        tahunPembuatan: json["tahun_pembuatan"] ?? '',
        tglDikeluarkan: json["tgl_dikeluarkan"] ?? '',
        type: json["type"] ?? '',
        warna: json["warna"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "alamat": alamat,
        "alamat_email": alamatEmail,
        "bahan_bakar": bahanBakar,
        "isi_silinder": isiSilinder,
        "jenis": jenis,
        "jumlah_roda": jumlahRoda,
        "jumlah_sumbu": jumlahSumbu,
        "lok_dikeluarkan": lokDikeluarkan,
        "merk": merk,
        "model": model,
        "nik": nik,
        "no_bpkb": noBpkb,
        "nomor_mesin": nomorMesin,
        "nomor_rangka": nomorRangka,
        "nomor_registrasi": nomorRegistrasi,
        "pekerjaan": pekerjaan,
        "pemilik": pemilik,
        "tahun_pembuatan": tahunPembuatan,
        "tgl_dikeluarkan": tglDikeluarkan,
        "type": type,
        "warna": warna,
      };
}

class Read2 {
  num alamat;
  num alamatEmail;
  num bahanBakar;
  num isiSilinder;
  num jenis;
  num jumlahRoda;
  num jumlahSumbu;
  num lokDikeluarkan;
  num merk;
  num model;
  num nik;
  num noBpkb;
  num nomorMesin;
  num nomorRangka;
  num nomorRegistrasi;
  num pekerjaan;
  num pemilik;
  num tahunPembuatan;
  num tglDikeluarkan;
  num type;
  num warna;

  Read2({
    required this.alamat,
    required this.alamatEmail,
    required this.bahanBakar,
    required this.isiSilinder,
    required this.jenis,
    required this.jumlahRoda,
    required this.jumlahSumbu,
    required this.lokDikeluarkan,
    required this.merk,
    required this.model,
    required this.nik,
    required this.noBpkb,
    required this.nomorMesin,
    required this.nomorRangka,
    required this.nomorRegistrasi,
    required this.pekerjaan,
    required this.pemilik,
    required this.tahunPembuatan,
    required this.tglDikeluarkan,
    required this.type,
    required this.warna,
  });

  factory Read2.fromJson(Map<String, dynamic> json) => Read2(
        alamat: json["alamat"] ?? 0,
        alamatEmail: json["alamat_email"] ?? 0,
        bahanBakar: json["bahan_bakar"] ?? 0,
        isiSilinder: json["isi_silinder"] ?? 0,
        jenis: json["jenis"] ?? 0,
        jumlahRoda: json["jumlah_roda"] ?? 0,
        jumlahSumbu: json["jumlah_sumbu"] ?? 0,
        lokDikeluarkan: json["lok_dikeluarkan"] ?? 0,
        merk: json["merk"] ?? 0,
        model: json["model"] ?? 0,
        nik: json["nik"] ?? 0,
        noBpkb: json["no_bpkb"] ?? 0,
        nomorMesin: json["nomor_mesin"] ?? 0,
        nomorRangka: json["nomor_rangka"] ?? 0,
        nomorRegistrasi: json["nomor_registrasi"] ?? 0,
        pekerjaan: json["pekerjaan"] ?? 0,
        pemilik: json["pemilik"] ?? 0,
        tahunPembuatan: json["tahun_pembuatan"] ?? 0,
        tglDikeluarkan: json["tgl_dikeluarkan"] ?? 0,
        type: json["type"] ?? 0,
        warna: json["warna"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "alamat": alamat,
        "alamat_email": alamatEmail,
        "bahan_bakar": bahanBakar,
        "isi_silinder": isiSilinder,
        "jenis": jenis,
        "jumlah_roda": jumlahRoda,
        "jumlah_sumbu": jumlahSumbu,
        "lok_dikeluarkan": lokDikeluarkan,
        "merk": merk,
        "model": model,
        "nik": nik,
        "no_bpkb": noBpkb,
        "nomor_mesin": nomorMesin,
        "nomor_rangka": nomorRangka,
        "nomor_registrasi": nomorRegistrasi,
        "pekerjaan": pekerjaan,
        "pemilik": pemilik,
        "tahun_pembuatan": tahunPembuatan,
        "tgl_dikeluarkan": tglDikeluarkan,
        "type": type,
        "warna": warna,
      };
}
