// To parse this JSON data, do
//
//     final kkocr = kkocrFromJson(jsonString);

import 'dart:convert';

Kkocr kkocrFromJson(String str) => Kkocr.fromJson(json.decode(str));

String kkocrToJson(Kkocr data) => json.encode(data.toJson());

class Kkocr {
  String message;
  String ocrDate;
  Read read;
  ReadConfidence readConfidence;
  String status;

  Kkocr({
    required this.message,
    required this.ocrDate,
    required this.read,
    required this.readConfidence,
    required this.status,
  });

  factory Kkocr.fromJson(Map<String, dynamic> json) => Kkocr(
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
  String alamat;
  String anggotaKeluarga;
  String desaKelurahan;
  String kabupatenKota;
  String kecamatan;
  String kodePos;
  String namaKepalaKeluarga;
  String nomorBlanko;
  String nomorKk;
  String provinsi;
  String rtRw;
  List<Table> table;
  String tanggalDikeluarkan;

  Read({
    required this.alamat,
    required this.anggotaKeluarga,
    required this.desaKelurahan,
    required this.kabupatenKota,
    required this.kecamatan,
    required this.kodePos,
    required this.namaKepalaKeluarga,
    required this.nomorBlanko,
    required this.nomorKk,
    required this.provinsi,
    required this.rtRw,
    required this.table,
    required this.tanggalDikeluarkan,
  });

  factory Read.fromJson(Map<String, dynamic> json) => Read(
        alamat: json["alamat"],
        anggotaKeluarga: json["anggota_keluarga"],
        desaKelurahan: json["desa_kelurahan"],
        kabupatenKota: json["kabupaten_kota"],
        kecamatan: json["kecamatan"],
        kodePos: json["kode_pos"],
        namaKepalaKeluarga: json["nama_kepala_keluarga"],
        nomorBlanko: json["nomor_blanko"],
        nomorKk: json["nomor_kk"],
        provinsi: json["provinsi"],
        rtRw: json["rt_rw"],
        table: List<Table>.from(json["table"].map((x) => Table.fromJson(x))),
        tanggalDikeluarkan: json["tanggal_dikeluarkan"],
      );

  Map<String, dynamic> toJson() => {
        "alamat": alamat,
        "anggota_keluarga": anggotaKeluarga,
        "desa_kelurahan": desaKelurahan,
        "kabupaten_kota": kabupatenKota,
        "kecamatan": kecamatan,
        "kode_pos": kodePos,
        "nama_kepala_keluarga": namaKepalaKeluarga,
        "nomor_blanko": nomorBlanko,
        "nomor_kk": nomorKk,
        "provinsi": provinsi,
        "rt_rw": rtRw,
        "table": List<dynamic>.from(table.map((x) => x.toJson())),
        "tanggal_dikeluarkan": tanggalDikeluarkan,
      };
}

class Table {
  String agama;
  String jenisKelamin;
  String jenisPekerjaan;
  String kewarganegaraan;
  String namaAyah;
  String namaIbu;
  String namaLengkap;
  String nik;
  int no;
  String noKitasKitap;
  String noPaspor;
  String pendidikan;
  String statusHubunganDalamKeluarga;
  String statusPerkawinan;
  String tanggalLahir;
  String tanggalPerkawinan;
  String tempatLahir;

  Table({
    required this.agama,
    required this.jenisKelamin,
    required this.jenisPekerjaan,
    required this.kewarganegaraan,
    required this.namaAyah,
    required this.namaIbu,
    required this.namaLengkap,
    required this.nik,
    required this.no,
    required this.noKitasKitap,
    required this.noPaspor,
    required this.pendidikan,
    required this.statusHubunganDalamKeluarga,
    required this.statusPerkawinan,
    required this.tanggalLahir,
    required this.tanggalPerkawinan,
    required this.tempatLahir,
  });

  factory Table.fromJson(Map<String, dynamic> json) => Table(
        agama: json["agama"],
        jenisKelamin: json["jenis_kelamin"],
        jenisPekerjaan: json["jenis_pekerjaan"],
        kewarganegaraan: json["kewarganegaraan"],
        namaAyah: json["nama_ayah"],
        namaIbu: json["nama_ibu"],
        namaLengkap: json["nama_lengkap"],
        nik: json["nik"],
        no: json["no"],
        noKitasKitap: json["no_kitas_kitap"],
        noPaspor: json["no_paspor"],
        pendidikan: json["pendidikan"],
        statusHubunganDalamKeluarga: json["status_hubungan_dalam_keluarga"],
        statusPerkawinan: json["status_perkawinan"],
        tanggalLahir: json["tanggal_lahir"],
        tanggalPerkawinan: json["tanggal_perkawinan"],
        tempatLahir: json["tempat_lahir"],
      );

  Map<String, dynamic> toJson() => {
        "agama": agamaValues.reverse[agama],
        "jenis_kelamin": jenisKelaminValues.reverse[jenisKelamin],
        "jenis_pekerjaan": jenisPekerjaan,
        "kewarganegaraan": kewarganegaraanValues.reverse[kewarganegaraan],
        "nama_ayah": namaAyah,
        "nama_ibu": namaIbu,
        "nama_lengkap": namaLengkap,
        "nik": nik,
        "no": no,
        "no_kitas_kitap": noKitasKitap,
        "no_paspor": noPaspor,
        "pendidikan": pendidikanValues.reverse[pendidikan],
        "status_hubungan_dalam_keluarga": statusHubunganDalamKeluarga,
        "status_perkawinan": statusPerkawinanValues.reverse[statusPerkawinan],
        "tanggal_lahir": tanggalLahir,
        "tanggal_perkawinan":
            tanggalPerkawinanValues.reverse[tanggalPerkawinan],
        "tempat_lahir": tempatLahirValues.reverse[tempatLahir],
      };
}

enum Agama { EMPTY, ISLAM }

final agamaValues = EnumValues({"": Agama.EMPTY, "ISLAM": Agama.ISLAM});

enum JenisKelamin { EMPTY, LAKI_LAKI, PEREMPUAN }

final jenisKelaminValues = EnumValues({
  "": JenisKelamin.EMPTY,
  "LAKI-LAKI": JenisKelamin.LAKI_LAKI,
  "PEREMPUAN": JenisKelamin.PEREMPUAN
});

enum Kewarganegaraan { EMPTY, WNI }

final kewarganegaraanValues =
    EnumValues({"": Kewarganegaraan.EMPTY, "WNI": Kewarganegaraan.WNI});

enum Pendidikan { DIPLOMA_IV_STRATA_I, EMPTY, TOWCOLM_BEKOLAH }

final pendidikanValues = EnumValues({
  "DIPLOMA IV/STRATA I": Pendidikan.DIPLOMA_IV_STRATA_I,
  "": Pendidikan.EMPTY,
  "TOWCOLM BEKOLAH": Pendidikan.TOWCOLM_BEKOLAH
});

enum StatusPerkawinan { BELUM_KAWIN, EMPTY, KAWIN_TERCATAT }

final statusPerkawinanValues = EnumValues({
  "BELUM KAWIN": StatusPerkawinan.BELUM_KAWIN,
  "": StatusPerkawinan.EMPTY,
  "KAWIN TERCATAT": StatusPerkawinan.KAWIN_TERCATAT
});

enum TanggalPerkawinan { EMPTY, THE_10032016, THE_16032018 }

final tanggalPerkawinanValues = EnumValues({
  "": TanggalPerkawinan.EMPTY,
  "10-03-2016": TanggalPerkawinan.THE_10032016,
  "16-03-2018": TanggalPerkawinan.THE_16032018
});

enum TempatLahir { BATU_BALANG, EMPTY, OKAITADI }

final tempatLahirValues = EnumValues({
  "BATU BALANG": TempatLahir.BATU_BALANG,
  "": TempatLahir.EMPTY,
  "OKAITADI": TempatLahir.OKAITADI
});

class ReadConfidence {
  double alamat;
  double desaKelurahan;
  double kabupatenKota;
  double kecamatan;
  double kodePos;
  double namaKepalaKeluarga;
  double nomorBlanko;
  double nomorKk;
  double provinsi;
  double rtRw;
  List<Table2> table2;
  double tanggalDikeluarkan;

  ReadConfidence({
    required this.alamat,
    required this.desaKelurahan,
    required this.kabupatenKota,
    required this.kecamatan,
    required this.kodePos,
    required this.namaKepalaKeluarga,
    required this.nomorBlanko,
    required this.nomorKk,
    required this.provinsi,
    required this.rtRw,
    required this.table2,
    required this.tanggalDikeluarkan,
  });

  factory ReadConfidence.fromJson(Map<String, dynamic> json) => ReadConfidence(
        alamat: json["alamat"]?.toDouble(),
        desaKelurahan: json["desa_kelurahan"]?.toDouble(),
        kabupatenKota: json["kabupaten_kota"]?.toDouble(),
        kecamatan: json["kecamatan"]?.toDouble(),
        kodePos: json["kode_pos"]?.toDouble(),
        namaKepalaKeluarga: json["nama_kepala_keluarga"]?.toDouble(),
        nomorBlanko: json["nomor_blanko"],
        nomorKk: json["nomor_kk"]?.toDouble(),
        provinsi: json["provinsi"]?.toDouble(),
        rtRw: json["rt_rw"]?.toDouble(),
        table2: List<Table2>.from(json["table"].map((x) => Table2.fromJson(x))),
        tanggalDikeluarkan: json["tanggal_dikeluarkan"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "alamat": alamat,
        "desa_kelurahan": desaKelurahan,
        "kabupaten_kota": kabupatenKota,
        "kecamatan": kecamatan,
        "kode_pos": kodePos,
        "nama_kepala_keluarga": namaKepalaKeluarga,
        "nomor_blanko": nomorBlanko,
        "nomor_kk": nomorKk,
        "provinsi": provinsi,
        "rt_rw": rtRw,
        "table": List<dynamic>.from(table2.map((x) => x.toJson())),
        "tanggal_dikeluarkan": tanggalDikeluarkan,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

class Table2 {
  double agama_confidence;
  double jenisKelamin_confidence;
  double jenisPekerjaan_confidence;
  double kewarganegaraan_confidence;
  double namaAyah_confidence;
  double namaIbu_confidence;
  double namaLengkap_confidence;
  double nik_confidence;
  int no_confidence;
  double noKitasKitap_confidence;
  double noPaspor_confidence;
  double pendidikan_confidence;
  double statusHubunganDalamKeluarga_confidence;
  double statusPerkawinan_confidence;
  double tanggalLahir_confidence;
  double tanggalPerkawinan_confidence;
  double tempatLahir_confidence;

  Table2({
    required this.agama_confidence,
    required this.jenisKelamin_confidence,
    required this.jenisPekerjaan_confidence,
    required this.kewarganegaraan_confidence,
    required this.namaAyah_confidence,
    required this.namaIbu_confidence,
    required this.namaLengkap_confidence,
    required this.nik_confidence,
    required this.no_confidence,
    required this.noKitasKitap_confidence,
    required this.noPaspor_confidence,
    required this.pendidikan_confidence,
    required this.statusHubunganDalamKeluarga_confidence,
    required this.statusPerkawinan_confidence,
    required this.tanggalLahir_confidence,
    required this.tanggalPerkawinan_confidence,
    required this.tempatLahir_confidence,
  });

  factory Table2.fromJson(Map<String, dynamic> json) => Table2(
        agama_confidence: json["agama"],
        jenisKelamin_confidence: json["jenis_kelamin"],
        jenisPekerjaan_confidence: json["jenis_pekerjaan"],
        kewarganegaraan_confidence: json["kewarganegaraan"],
        namaAyah_confidence: json["nama_ayah"],
        namaIbu_confidence: json["nama_ibu"],
        namaLengkap_confidence: json["nama_lengkap"],
        nik_confidence: json["nik"],
        no_confidence: json["no"],
        noKitasKitap_confidence: json["no_kitas_kitap"],
        noPaspor_confidence: json["no_paspor"],
        pendidikan_confidence: json["pendidikan"],
        statusHubunganDalamKeluarga_confidence:
            json["status_hubungan_dalam_keluarga"],
        statusPerkawinan_confidence: json["status_perkawinan"],
        tanggalLahir_confidence: json["tanggal_lahir"],
        tanggalPerkawinan_confidence: json["tanggal_perkawinan"],
        tempatLahir_confidence: json["tempat_lahir"],
      );

  Map<String, dynamic> toJson() => {
        "agama": agamaValues.reverse[agama_confidence],
        "jenis_kelamin": jenisKelaminValues.reverse[jenisKelamin_confidence],
        "jenis_pekerjaan": jenisPekerjaan_confidence,
        "kewarganegaraan":
            kewarganegaraanValues.reverse[kewarganegaraan_confidence],
        "nama_ayah": namaAyah_confidence,
        "nama_ibu": namaIbu_confidence,
        "nama_lengkap": namaLengkap_confidence,
        "nik": nik_confidence,
        "no": no_confidence,
        "no_kitas_kitap": noKitasKitap_confidence,
        "no_paspor": noPaspor_confidence,
        "pendidikan": pendidikanValues.reverse[pendidikan_confidence],
        "status_hubungan_dalam_keluarga":
            statusHubunganDalamKeluarga_confidence,
        "status_perkawinan":
            statusPerkawinanValues.reverse[statusPerkawinan_confidence],
        "tanggal_lahir": tanggalLahir_confidence,
        "tanggal_perkawinan":
            tanggalPerkawinanValues.reverse[tanggalPerkawinan_confidence],
        "tempat_lahir": tempatLahirValues.reverse[tempatLahir_confidence],
      };
}
