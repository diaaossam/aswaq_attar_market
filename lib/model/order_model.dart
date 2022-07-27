import '../shared/helper/mangers/constants.dart';

class OrderModel {
  String? orderId;
  List<dynamic> order = [];
  double? totalPrice;
  String? phone;
  String? date;
  String? time;
  String? userName;
  String? userId;
  String? address;
  String? reply;
  bool? isAdminSeen;

  OrderModel(
      {this.orderId = ConstantsManger.DEFULT,
        required this.order,
        required this.totalPrice,
        required this.date,
        required this.time,
        required this.userName,
        required this.userId,
        required this.address,
        required this.phone,
        this.reply = ConstantsManger.DEFULT,
        this.isAdminSeen = false});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    phone = json['phone'];
    totalPrice = json['totalPrice'];
    date = json['date'];
    time = json['time'];
    userName = json['userName'];
    userId = json['userId'];
    reply= json["reply"];
    address = json['address'];
    isAdminSeen = json['isAdminSeen'];
    if (json['order'] != null) {
      json['order'].forEach((item) {
        order.add(item);
      });
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "orderId": orderId,
      "order": order.map((e) => e.toMap()).toList(),
      "totalPrice": totalPrice,
      "date": date,
      "time": time,
      "userName": userName,
      "userId": userId,
      "address": address,
      "isAdminSeen": isAdminSeen,
      "reply": reply,
      "phone": phone,
    };
  }
}
