import 'dart:convert';

OcrPaspor ocrPasporFromJson(String str) => OcrPaspor.fromJson(json.decode(str));

String ocrPasporToJson(OcrPaspor data) => json.encode(data.toJson());

class OcrPaspor {
  String? message;
  String? ocrDate;
  Read read;
  ReadConfidence readConfidence;
  String? status;

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
  String? country;
  String? dateBirth;
  String? dateExpire;
  String? dateOfIssue;
  String? gender;
  String? issueOffice;
  String? mrz;
  String? name;
  String? nationality;
  String? passportNo;
  String? passportType;
  String? placeOfBirth;
  String? surname;

  Read({
    required this.country,
    required this.dateBirth,
    required this.dateExpire,
    required this.dateOfIssue,
    required this.gender,
    required this.issueOffice,
    required this.mrz,
    required this.name,
    required this.nationality,
    required this.passportNo,
    required this.passportType,
    required this.placeOfBirth,
    required this.surname,
  });

  factory Read.fromJson(Map<String, dynamic> json) => Read(
        country: json["country"],
        dateBirth: json["date_birth"],
        dateExpire: json["date_expire"],
        dateOfIssue: json["date_of_issue"],
        gender: json["gender"],
        issueOffice: json["issue_office"],
        mrz: json["mrz"],
        name: json["name"],
        nationality: json["nationality"],
        passportNo: json["passport_no"],
        passportType: json["passport_type"],
        placeOfBirth: json["place_of_birth"],
        surname: json["surname"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "date_birth": dateBirth,
        "date_expire": dateExpire,
        "date_of_issue": dateOfIssue,
        "gender": gender,
        "issue_office": issueOffice,
        "mrz": mrz,
        "name": name,
        "nationality": nationality,
        "passport_no": passportNo,
        "passport_type": passportType,
        "place_of_birth": placeOfBirth,
        "surname": surname,
      };
}

class ReadConfidence {
  double? country;
  double? dateBirth;
  double? dateExpire;
  double? dateOfIssue;
  double? gender;
  double? issueOffice;
  double? mrz;
  double? name;
  double? nationality;
  double? passportNo;
  double? passportType;
  double? placeOfBirth;
  double? surname;

  ReadConfidence({
    required this.country,
    required this.dateBirth,
    required this.dateExpire,
    required this.dateOfIssue,
    required this.gender,
    required this.issueOffice,
    required this.mrz,
    required this.name,
    required this.nationality,
    required this.passportNo,
    required this.passportType,
    required this.placeOfBirth,
    required this.surname,
  });

  factory ReadConfidence.fromJson(Map<String, dynamic> json) => ReadConfidence(
        country: json["country"]?.toDouble(),
        dateBirth: json["date_birth"]?.toDouble(),
        dateExpire: json["date_expire"]?.toDouble(),
        dateOfIssue: json["date_of_issue"]?.toDouble(),
        gender: json["gender"]?.toDouble(),
        issueOffice: json["issue_office"]?.toDouble(),
        mrz: json["mrz"]?.toDouble(),
        name: json["name"]?.toDouble(),
        nationality: json["nationality"]?.toDouble(),
        passportNo: json["passport_no"]?.toDouble(),
        passportType: json["passport_type"]?.toDouble(),
        placeOfBirth: json["place_of_birth"]?.toDouble(),
        surname: json["surname"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "date_birth": dateBirth,
        "date_expire": dateExpire,
        "date_of_issue": dateOfIssue,
        "gender": gender,
        "issue_office": issueOffice,
        "mrz": mrz,
        "name": name,
        "nationality": nationality,
        "passport_no": passportNo,
        "passport_type": passportType,
        "place_of_birth": placeOfBirth,
        "surname": surname,
      };
}
