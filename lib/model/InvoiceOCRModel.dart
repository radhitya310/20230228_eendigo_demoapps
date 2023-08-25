// To parse this JSON data, do
//
//     final invoiceOcrModel = invoiceOcrModelFromJson(jsonString);

import 'dart:convert';

InvoiceOcrModel invoiceOcrModelFromJson(String str) =>
    InvoiceOcrModel.fromJson(json.decode(str));

String invoiceOcrModelToJson(InvoiceOcrModel data) =>
    json.encode(data.toJson());

class InvoiceOcrModel {
  List<InvoiceInfo>? invoiceInfo;
  List<Other>? other;
  List<Payment>? payment;
  List<InvoiceInfo>? receiver;
  List<Table>? table;
  List<InvoiceInfo>? vendor;

  InvoiceOcrModel({
    this.invoiceInfo,
    this.other,
    this.payment,
    this.receiver,
    this.table,
    this.vendor,
  });

  InvoiceOcrModel copyWith({
    List<InvoiceInfo>? invoiceInfo,
    List<Other>? other,
    List<Payment>? payment,
    List<InvoiceInfo>? receiver,
    List<Table>? table,
    List<InvoiceInfo>? vendor,
  }) =>
      InvoiceOcrModel(
        invoiceInfo: invoiceInfo ?? this.invoiceInfo,
        other: other ?? this.other,
        payment: payment ?? this.payment,
        receiver: receiver ?? this.receiver,
        table: table ?? this.table,
        vendor: vendor ?? this.vendor,
      );

  factory InvoiceOcrModel.fromJson(Map<String, dynamic> json) =>
      InvoiceOcrModel(
        invoiceInfo: json["Invoice Info"] == null
            ? []
            : List<InvoiceInfo>.from(
                json["Invoice Info"]!.map((x) => InvoiceInfo.fromJson(x))),
        other: json["Other"] == null
            ? []
            : List<Other>.from(json["Other"]!.map((x) => Other.fromJson(x))),
        payment: json["Payment"] == null
            ? []
            : List<Payment>.from(
                json["Payment"]!.map((x) => Payment.fromJson(x))),
        receiver: json["Receiver"] == null
            ? []
            : List<InvoiceInfo>.from(
                json["Receiver"]!.map((x) => InvoiceInfo.fromJson(x))),
        table: json["Table"] == null
            ? []
            : List<Table>.from(json["Table"]!.map((x) => Table.fromJson(x))),
        vendor: json["Vendor"] == null
            ? []
            : List<InvoiceInfo>.from(
                json["Vendor"]!.map((x) => InvoiceInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Invoice Info": invoiceInfo == null
            ? []
            : List<dynamic>.from(invoiceInfo!.map((x) => x.toJson())),
        "Other": other == null
            ? []
            : List<dynamic>.from(other!.map((x) => x.toJson())),
        "Payment": payment == null
            ? []
            : List<dynamic>.from(payment!.map((x) => x.toJson())),
        "Receiver": receiver == null
            ? []
            : List<dynamic>.from(receiver!.map((x) => x.toJson())),
        "Table": table == null
            ? []
            : List<dynamic>.from(table!.map((x) => x.toJson())),
        "Vendor": vendor == null
            ? []
            : List<dynamic>.from(vendor!.map((x) => x.toJson())),
      };
}

class InvoiceInfo {
  double? confidenceLabel = 0;
  double? confidenceValue = 0;
  String? label;
  String? value;

  InvoiceInfo({
    this.confidenceLabel,
    this.confidenceValue,
    this.label,
    this.value,
  });

  InvoiceInfo copyWith({
    double? confidenceLabel = 0,
    double? confidenceValue = 0,
    String? label,
    String? value,
  }) =>
      InvoiceInfo(
        confidenceLabel: confidenceLabel ?? this.confidenceLabel,
        confidenceValue: confidenceValue ?? this.confidenceValue,
        label: label ?? this.label,
        value: value ?? this.value,
      );

  factory InvoiceInfo.fromJson(Map<String, dynamic> json) => InvoiceInfo(
        confidenceLabel: json["confidence_label"].toString() == ""
            ? 0
            : json["confidence_label"]?.toDouble(),
        confidenceValue: json["confidence_value"].toString() == ""
            ? 0
            : json["confidence_value"]?.toDouble(),
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "confidence_label": confidenceLabel,
        "confidence_value": confidenceValue,
        "label": label,
        "value": value,
      };
}

class Other {
  double? confidenceLabel = 0;
  double? confidenceValue = 0;
  String? label;
  String? value;

  Other({
    this.confidenceLabel,
    this.confidenceValue,
    this.label,
    this.value,
  });

  Other copyWith({
    double? confidenceLabel,
    double? confidenceValue,
    String? label,
    String? value,
  }) =>
      Other(
        confidenceLabel: confidenceLabel ?? this.confidenceLabel,
        confidenceValue: confidenceValue ?? this.confidenceValue,
        label: label ?? this.label,
        value: value ?? this.value,
      );

  factory Other.fromJson(Map<String, dynamic> json) => Other(
        confidenceLabel: json["confidence_label"].toString() == ""
            ? 0
            : json["confidence_label"]?.toDouble(),
        confidenceValue: json["confidence_value"].toString() == ""
            ? 0
            : json["confidence_value"]?.toDouble(),
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "confidence_label": confidenceLabel,
        "confidence_value": confidenceValue,
        "label": label,
        "value": value,
      };
}

class Payment {
  int? page;
  List<RowElement>? info;

  Payment({
    this.page,
    this.info,
  });

  Payment copyWith({
    int? page,
    List<RowElement>? info,
  }) =>
      Payment(
        page: page ?? this.page,
        info: info ?? this.info,
      );

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        page: json["Page"],
        info: json["info"] == null
            ? []
            : List<RowElement>.from(
                json["info"]!.map((x) => RowElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Page": page,
        "info": info == null
            ? []
            : List<dynamic>.from(info!.map((x) => x.toJson())),
      };
}

class RowElement {
  double? confidenceLabel = 0;
  double? confidenceType = 0;
  double? confidenceValue = 0;
  String? label;
  String? type;
  String? value;

  RowElement({
    this.confidenceLabel = 0,
    this.confidenceType = 0,
    this.confidenceValue = 0,
    this.label,
    this.type,
    this.value,
  });

  RowElement copyWith({
    double? confidenceLabel,
    double? confidenceType,
    double? confidenceValue,
    String? label,
    String? type,
    String? value,
  }) =>
      RowElement(
        confidenceLabel: confidenceLabel ?? this.confidenceLabel,
        confidenceType: confidenceType ?? this.confidenceType,
        confidenceValue: confidenceValue ?? this.confidenceValue,
        label: label ?? this.label,
        type: type ?? this.type,
        value: value ?? this.value,
      );

  factory RowElement.fromJson(Map<String, dynamic> json) => RowElement(
        confidenceLabel: json["confidence_label"].toString() == ""
            ? 0
            : json["confidence_label"]?.toDouble(),
        confidenceType: json["confidence_type"].toString() == ""
            ? 0
            : json["confidence_type"]?.toDouble(),
        confidenceValue: json["confidence_value"].toString() == ""
            ? 0
            : json["confidence_value"]?.toDouble(),
        label: json["label"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "confidence_label": confidenceLabel,
        "confidence_type": confidenceType,
        "confidence_value": confidenceValue,
        "label": label,
        "type": type,
        "value": value,
      };
}

class Table {
  int? page;
  List<TableInfo>? info;

  Table({
    this.page,
    this.info,
  });

  Table copyWith({
    int? page,
    List<TableInfo>? info,
  }) =>
      Table(
        page: page ?? this.page,
        info: info ?? this.info,
      );

  factory Table.fromJson(Map<String, dynamic> json) => Table(
        page: json["Page"],
        info: json["info"] == null
            ? []
            : List<TableInfo>.from(
                json["info"]!.map((x) => TableInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Page": page,
        "info": info == null
            ? []
            : List<dynamic>.from(info!.map((x) => x.toJson())),
      };
}

class TableInfo {
  List<RowElement>? row;

  TableInfo({
    this.row,
  });

  TableInfo copyWith({
    List<RowElement>? row,
  }) =>
      TableInfo(
        row: row ?? this.row,
      );

  factory TableInfo.fromJson(Map<String, dynamic> json) => TableInfo(
        row: json["row"] == null
            ? []
            : List<RowElement>.from(
                json["row"]!.map((x) => RowElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "row":
            row == null ? [] : List<dynamic>.from(row!.map((x) => x.toJson())),
      };
}
