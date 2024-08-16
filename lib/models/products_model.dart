class ProductModel {
  num? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? discountPercentage;
  double? rating;
  num? stock;
  String? brand;
  String? warrantyInformation;
  String? returnPolicy;
  String? thumbnail;

  ProductModel({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.brand,
    this.warrantyInformation,
    this.returnPolicy,
    this.thumbnail
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      price: (json['price'] as num?)?.toDouble(),
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      stock: json['stock'],
      brand: json['brand'],
      warrantyInformation: json['warrantyInformation'],
      returnPolicy: json['returnPolicy'],
        thumbnail:json['thumbnail']
    );
  }

  Map<String, dynamic> toJson(ProductModel product) {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'brand': brand,
      'warrantyInformation': warrantyInformation,
      'returnPolicy': returnPolicy,
      'thumbnail':thumbnail
    };
  }
}