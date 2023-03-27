// To parse this JSON data, do
//
//     final rekbcaocr = rekbcaocrFromJson(jsonString);

import 'dart:convert';

Rekbcaocr rekbcaocrFromJson(String str) => Rekbcaocr.fromJson(json.decode(str));

String rekbcaocrToJson(Rekbcaocr data) => json.encode(data.toJson());

class Rekbcaocr {
  Rekbcaocr({
    required this.message,
    required this.numOfPages,
    required this.ocrDate,
    required this.read,
    required this.status,
  });

  String message;
  int numOfPages;
  String ocrDate;
  Read read;
  String status;

  factory Rekbcaocr.fromJson(Map<String, dynamic> json) => Rekbcaocr(
        message: json["message"],
        numOfPages: json["num_of_pages"],
        ocrDate: json["ocr_date"],
        read: Read.fromJson(json["read"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "num_of_pages": numOfPages,
        "ocr_date": ocrDate,
        "read": read.toJson(),
        "status": status,
      };
}

class Read {
  Read({
    required this.identity,
    required this.transactionHistory,
    required this.transactionSummary,
  });

  Identity identity;
  List<TransactionHistory> transactionHistory;
  List<TransactionSummary> transactionSummary;

  factory Read.fromJson(Map<String, dynamic> json) => Read(
        identity: Identity.fromJson(json["Identity"]),
        transactionHistory: List<TransactionHistory>.from(
            json["TransactionHistory"]
                .map((x) => TransactionHistory.fromJson(x))),
        transactionSummary: List<TransactionSummary>.from(
            json["TransactionSummary"]
                .map((x) => TransactionSummary.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Identity": identity.toJson(),
        "TransactionHistory":
            List<dynamic>.from(transactionHistory.map((x) => x.toJson())),
        "TransactionSummary":
            List<dynamic>.from(transactionSummary.map((x) => x.toJson())),
      };
}

class Identity {
  Identity({
    required this.accountNumber,
    required this.alternateIncome1,
    required this.alternateIncome2,
    required this.alternateIncome3,
    required this.alternateIncome4,
    required this.alternateIncomeFinal,
    required this.bankOffice,
    required this.creditTransactionsLast3Months,
    required this.debitTransactionsLast3Months,
    required this.endingBalance,
    required this.name,
    required this.totalTransactionsCreditLast3Months,
    required this.totalTransactionsDebitLast3Months,
    required this.totalTransactionsLast3Months,
    required this.warningMutasi1,
    required this.warningMutasi1Description,
  });

  String accountNumber;
  double alternateIncome1;
  double alternateIncome2;
  double alternateIncome3;
  double alternateIncome4;
  double alternateIncomeFinal;
  String bankOffice;
  double creditTransactionsLast3Months;
  double debitTransactionsLast3Months;
  double endingBalance;
  String name;
  double totalTransactionsCreditLast3Months;
  double totalTransactionsDebitLast3Months;
  double totalTransactionsLast3Months;
  bool warningMutasi1;
  String warningMutasi1Description;

  factory Identity.fromJson(Map<String, dynamic> json) => Identity(
        accountNumber: json["AccountNumber"],
        alternateIncome1: json["AlternateIncome1"]?.toDouble(),
        alternateIncome2: json["AlternateIncome2"]?.toDouble(),
        alternateIncome3: json["AlternateIncome3"]?.toDouble(),
        alternateIncome4: json["AlternateIncome4"]?.toDouble(),
        alternateIncomeFinal: json["AlternateIncomeFinal"]?.toDouble(),
        bankOffice: json["BankOffice"],
        creditTransactionsLast3Months:
            json["CreditTransactionsLast3Months"]?.toDouble(),
        debitTransactionsLast3Months:
            json["DebitTransactionsLast3Months"]?.toDouble(),
        endingBalance: json["EndingBalance"]?.toDouble(),
        name: json["Name"],
        totalTransactionsCreditLast3Months:
            json["TotalTransactionsCreditLast3Months"],
        totalTransactionsDebitLast3Months:
            json["TotalTransactionsDebitLast3Months"],
        totalTransactionsLast3Months: json["TotalTransactionsLast3Months"],
        warningMutasi1: json["WarningMutasi1"],
        warningMutasi1Description: json["WarningMutasi1Description"],
      );

  Map<String, dynamic> toJson() => {
        "AccountNumber": accountNumber,
        "AlternateIncome1": alternateIncome1,
        "AlternateIncome2": alternateIncome2,
        "AlternateIncome3": alternateIncome3,
        "AlternateIncome4": alternateIncome4,
        "AlternateIncomeFinal": alternateIncomeFinal,
        "BankOffice": bankOffice,
        "CreditTransactionsLast3Months": creditTransactionsLast3Months,
        "DebitTransactionsLast3Months": debitTransactionsLast3Months,
        "EndingBalance": endingBalance,
        "Name": name,
        "TotalTransactionsCreditLast3Months":
            totalTransactionsCreditLast3Months,
        "TotalTransactionsDebitLast3Months": totalTransactionsDebitLast3Months,
        "TotalTransactionsLast3Months": totalTransactionsLast3Months,
        "WarningMutasi1": warningMutasi1,
        "WarningMutasi1Description": warningMutasi1Description,
      };
}

class TransactionHistory {
  TransactionHistory({
    required this.amount,
    required this.date,
    required this.description,
    required this.endingBalance,
    required this.type,
  });

  double amount;
  String date;
  String description;
  double endingBalance;
  Type type;

  factory TransactionHistory.fromJson(Map<String, dynamic> json) =>
      TransactionHistory(
        amount: json["Amount"],
        date: json["Date"],
        description: json["Description"],
        endingBalance: json["EndingBalance"]?.toDouble(),
        type: typeValues.map[json["Type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "Amount": amount,
        "Date": date,
        "Description": description,
        "EndingBalance": endingBalance,
        "Type": typeValues.reverse[type],
      };
}

enum Type { DEBIT, CREDIT }

final typeValues = EnumValues({"CREDIT": Type.CREDIT, "DEBIT": Type.DEBIT});

class TransactionSummary {
  TransactionSummary({
    required this.beginningBalance,
    required this.credit,
    required this.creditFreq,
    required this.debit,
    required this.debitFreq,
    required this.endingBalance,
    required this.period,
    required this.warningMutasi2,
    required this.warningMutasi2Description,
  });

  double beginningBalance;
  double credit;
  double creditFreq;
  double debit;
  double debitFreq;
  double endingBalance;
  String period;
  bool warningMutasi2;
  String warningMutasi2Description;

  factory TransactionSummary.fromJson(Map<String, dynamic> json) =>
      TransactionSummary(
        beginningBalance: json["BeginningBalance"]?.toDouble(),
        credit: json["Credit"]?.toDouble(),
        creditFreq: json["CreditFreq"],
        debit: json["Debit"]?.toDouble(),
        debitFreq: json["DebitFreq"],
        endingBalance: json["EndingBalance"]?.toDouble(),
        period: json["Period"],
        warningMutasi2: json["WarningMutasi2"],
        warningMutasi2Description: json["WarningMutasi2Description"],
      );

  Map<String, dynamic> toJson() => {
        "BeginningBalance": beginningBalance,
        "Credit": credit,
        "CreditFreq": creditFreq,
        "Debit": debit,
        "DebitFreq": debitFreq,
        "EndingBalance": endingBalance,
        "Period": period,
        "WarningMutasi2": warningMutasi2,
        "WarningMutasi2Description": warningMutasi2Description,
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
