class APIKeyModel {
  String tenantCode;
  String key;

  APIKeyModel({required this.tenantCode, required this.key});

  factory APIKeyModel.fromJson(Map<String, dynamic> json) {
    return APIKeyModel(
      tenantCode: json['tenantCode'] as String,
      key: json['key'] as String,
    );
  }
}