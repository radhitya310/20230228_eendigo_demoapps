// To parse this JSON data, do
//
//     final kkocr = kkocrFromJson(jsonString);

import 'dart:convert';

Kkocr kkocrFromJson(String str) => Kkocr.fromJson(json.decode(str));

String kkocrToJson(Kkocr data) => json.encode(data.toJson());

class Kkocr {
    Kkocr({
        required this.message,
        required this.ocrDate,
        required this.read,
        required this.status,
    });

    String message;
    String ocrDate;
    Read read;
    String status;

    factory Kkocr.fromJson(Map<String, dynamic> json) => Kkocr(
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

    factory Table.fromJson(Map<String, dynamic> json) => Table(
        agama: json["agama"]!,
        jenisKelamin: json["jenis_kelamin"]!,
        jenisPekerjaan: json["jenis_pekerjaan"],
        kewarganegaraan: json["kewarganegaraan"]!,
        namaAyah: json["nama_ayah"],
        namaIbu: json["nama_ibu"],
        namaLengkap: json["nama_lengkap"],
        nik: json["nik"],
        no: json["no"],
        noKitasKitap: json["no_kitas_kitap"],
        noPaspor: json["no_paspor"],
        pendidikan: json["pendidikan"]!,
        statusHubunganDalamKeluarga: json["status_hubungan_dalam_keluarga"],
        statusPerkawinan: json["status_perkawinan"]!,
        tanggalLahir: json["tanggal_lahir"],
        tanggalPerkawinan: json["tanggal_perkawinan"]!,
        tempatLahir: json["tempat_lahir"]!,
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
        "tanggal_perkawinan": tanggalPerkawinanValues.reverse[tanggalPerkawinan],
        "tempat_lahir": tempatLahirValues.reverse[tempatLahir],
    };
}

enum Agama { ISLAM, EMPTY }

final agamaValues = EnumValues({
    "": Agama.EMPTY,
    "ISLAM": Agama.ISLAM
});

enum JenisKelamin { LAKI_LAKI, PEREMPUAN, EMPTY }

final jenisKelaminValues = EnumValues({
    "": JenisKelamin.EMPTY,
    "LAKI-LAKI": JenisKelamin.LAKI_LAKI,
    "PEREMPUAN": JenisKelamin.PEREMPUAN
});

enum Kewarganegaraan { WNI, EMPTY }

final kewarganegaraanValues = EnumValues({
    "": Kewarganegaraan.EMPTY,
    "WNI": Kewarganegaraan.WNI
});

enum Pendidikan { DIPLOMA_IV_STRATA_I, TOWCOLM_BEKOLAH, EMPTY }

final pendidikanValues = EnumValues({
    "DIPLOMA IV/STRATA I": Pendidikan.DIPLOMA_IV_STRATA_I,
    "": Pendidikan.EMPTY,
    "TOWCOLM BEKOLAH": Pendidikan.TOWCOLM_BEKOLAH
});

enum StatusPerkawinan { KAWIN_TERCATAT, BELUM_KAWIN, EMPTY }

final statusPerkawinanValues = EnumValues({
    "BELUM KAWIN": StatusPerkawinan.BELUM_KAWIN,
    "": StatusPerkawinan.EMPTY,
    "KAWIN TERCATAT": StatusPerkawinan.KAWIN_TERCATAT
});

enum TanggalPerkawinan { THE_16032018, THE_10032016, EMPTY }

final tanggalPerkawinanValues = EnumValues({
    "": TanggalPerkawinan.EMPTY,
    "10-03-2016": TanggalPerkawinan.THE_10032016,
    "16-03-2018": TanggalPerkawinan.THE_16032018
});

enum TempatLahir { BATU_BALANG, OKAITADI, EMPTY }

final tempatLahirValues = EnumValues({
    "BATU BALANG": TempatLahir.BATU_BALANG,
    "": TempatLahir.EMPTY,
    "OKAITADI": TempatLahir.OKAITADI
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
