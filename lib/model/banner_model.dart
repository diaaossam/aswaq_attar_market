class BannerModel{
  String ?id;
  String ? image;

  BannerModel({required this.id,required this.image});

  BannerModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    image = json['image'];
  }
  Map<String , dynamic> toMap(){
    return {
      "image":image,
      "id":id,
    };
  }
}