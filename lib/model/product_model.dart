class ProductModel {
  String? id;
  String? title;
  String? description;
  String? image;
  double? price;
  double? newPrice;
  bool? isFav;
  bool? isPopular;
  bool? hasDiscount;
  String ? category ;
  String ? department ;

  ProductModel(
      {required this.id,
        required this.title,
        required this.description,
        required this.image,
        required this.price,
        required this.isFav,
        required this.isPopular ,
        this.category,
        this.department,
        this.newPrice=0.0,
        this.hasDiscount = false,
      });

  ProductModel.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    price = map['price'];
    image = map['image'];
    isFav = map['isFav'];
    isPopular = map['isPopular'];
    category = map['category'];
    department = map['department'];
    newPrice = map['newPrice'];
    hasDiscount = map['hasDiscount'];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "image": image,
      "price": price,
      "isFav": isFav,
      "isPopular": isPopular,
      "category": category,
      "department": department,
      "newPrice": newPrice,
      "hasDiscount": hasDiscount,
    };
  }
}

