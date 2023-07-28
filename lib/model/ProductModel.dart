class ProductsModel {
  final List<ProductModel> data;

  ProductsModel({
    required this.data
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    final data = (json['data'] as List<dynamic>)
        .map((dataJson) => ProductModel.fromJson(dataJson))
        .toList();

    return ProductsModel(
      data: data
    );
  }
}

class ProductModel {
  String name;
  String url;
  String key;
  String timeout;

  ProductModel({required this.name, required this.url, required this.key, required this.timeout});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'] as String,
      url: json['url'] as String,
      key: json['key'] as String,
      timeout: json['timeout'] as String,
    );
  }
}
