class FavModel {
  String? productId;
  String ? userId;
  String? title;
  String? image;
  double? price;
  bool? isFav;

  FavModel(
      {required this.productId,
      required this.title,
      required this.image,
      required this.price,
        this.isFav,
      required this.userId});

  FavModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    userId = json['userId'];
    title = json['title'];
    image = json['image'];
    price = json['price'];
    isFav = json['isFav'];
  }

  Map<String, dynamic> toMap() {
    return {
      "productId": productId,
      "userId": userId,
      "title": title,
      "image": image,
      "price": price,
      "isFav": isFav,
    };
  }
}
