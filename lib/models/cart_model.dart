class CartProductModel {
  int? id;
  String? title;
  String? images;
  int? quantity;
  num? price;

  CartProductModel({
    this.id,
    this.title,
    this.price,
    this.quantity,
    this.images
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        quantity: json['quantity'],
      images: json['images']
    );
  }

  Map<String, dynamic> toJson(CartProductModel product) {
    return {
      'id': id,
      'title': title,
      'price': price,
      'quantity':quantity,
      'images': images,
    };
  }
}