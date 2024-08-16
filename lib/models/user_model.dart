class UsersModel {
  int? id;
  String? image;
  String? name;
  String? email;
  String? phone;
  String? password;

  UsersModel({
    this.id,
    this.name,
    this.image,
    this.email,
    this.phone,
    this.password,
    // this.rating,
  });

  factory UsersModel.fromJson(Map<String, dynamic> data) {
    return UsersModel(
      id:data["id"],
      image: data['image'],
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      password: data['password'],
      );
  }

  Map<String, dynamic> toJson(UsersModel data) {
    return {
      "image": data.image,
      "name": data.name,
      "email": data.email,
      "phone": data.phone,
      "password": data.password,
      // "rating": data.rating!.toJson(data.rating!)
    };
  }
}
