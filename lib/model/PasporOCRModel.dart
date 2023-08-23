import 'dart:convert';

OcrPaspor ocrPasporFromJson(String str) => OcrPaspor.fromJson(json.decode(str));

String ocrPasporToJson(OcrPaspor data) => json.encode(data.toJson());

class OcrPaspor {
  String message;
  String ocrDate;
  Read read;
  ReadConfidence readConfidence;
  String status;

  OcrPaspor({
    required this.message,
    required this.ocrDate,
    required this.read,
    required this.readConfidence,
    required this.status,
  });

  factory OcrPaspor.fromJson(Map<String, dynamic> json) => OcrPaspor(
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
  String country;
  String dateBirth;
  String dateExpire;
  String gender;
  String idNo;
  String name;
  String nationality;
  String passportNo;
  String passportType;
  String surname;

  Read({
    required this.country,
    required this.dateBirth,
    required this.dateExpire,
    required this.gender,
    required this.idNo,
    required this.name,
    required this.nationality,
    required this.passportNo,
    required this.passportType,
    required this.surname,
  });

  factory Read.fromJson(Map<String, dynamic> json) => Read(
        country: json["country"],
        dateBirth: json["date_birth"],
        dateExpire: json["date_expire"],
        gender: json["gender"],
        idNo: json["id_no"],
        name: json["name"],
        nationality: json["nationality"],
        passportNo: json["passport_no"],
        passportType: json["passport_type"],
        surname: json["surname"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "date_birth": dateBirth,
        "date_expire": dateExpire,
        "gender": gender,
        "id_no": idNo,
        "name": name,
        "nationality": nationality,
        "passport_no": passportNo,
        "passport_type": passportType,
        "surname": surname,
      };
}

class ReadConfidence {
  num country;
  num dateBirth;
  num dateExpire;
  num gender;
  num idNo;
  num name;
  num nationality;
  num passportNo;
  num passportType;
  num surname;

  ReadConfidence({
    required this.country,
    required this.dateBirth,
    required this.dateExpire,
    required this.gender,
    required this.idNo,
    required this.name,
    required this.nationality,
    required this.passportNo,
    required this.passportType,
    required this.surname,
  });

  factory ReadConfidence.fromJson(Map<String, dynamic> json) => ReadConfidence(
        country: json["country"]?.toDouble(),
        dateBirth: json["date_birth"]?.toDouble(),
        dateExpire: json["date_expire"]?.toDouble(),
        gender: json["gender"]?.toDouble(),
        idNo: json["id_no"]?.toDouble(),
        name: json["name"]?.toDouble(),
        nationality: json["nationality"]?.toDouble(),
        passportNo: json["passport_no"]?.toDouble(),
        passportType: json["passport_type"]?.toDouble(),
        surname: json["surname"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "date_birth": dateBirth,
        "date_expire": dateExpire,
        "gender": gender,
        "id_no": idNo,
        "name": name,
        "nationality": nationality,
        "passport_no": passportNo,
        "passport_type": passportType,
        "surname": surname,
      };
}
