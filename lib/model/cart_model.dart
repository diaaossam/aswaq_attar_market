import '../shared/helper/mangers/constants.dart';

class CartModel {
  String? id;
  String? title;
  String? description;
  String? image;
  double? totalPrice;
  int ? count;
  String ? details;
  bool? isFav;
  bool? isPopular;


  CartModel(
      {required this.id,
        required this.title,
        this.description = ConstantsManger.DEFULT,
        this.details = ConstantsManger.DEFULT,
        required this.image,
        required this.totalPrice,
        required this.count,
        this.isFav = false,
        this.isPopular = false,
      });

  CartModel.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
    isFav = map['isFav'];
    isPopular = map['isPopular'];
    image = map['image'];
    totalPrice = map['totalPrice'];
    count = map['count'];
    details = map['details'];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "image": image,
      "isFav": isFav,
      "isPopular": isPopular,
      "count": count,
      "details": details,
      "totalPrice": totalPrice,
    };
  }
}
