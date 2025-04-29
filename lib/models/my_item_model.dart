import 'dart:convert';

List<MyItemModel> getProItemsFromBack(response) {
  var fromResponse = jsonDecode(response)['data']['products'];

 return List.from(fromResponse.map((item)=>MyItemModel.itemPro(item)));
}

class MyItemModel {
  bool? discountN;
  String? prodImage;
  int? priceAfterDiscount;
  int? price;
  String? prodName;

  MyItemModel({
    required this.discountN,
    required this.prodImage,
    required this.priceAfterDiscount,
    required this.price,
    required this.prodName,
  });

  // Factory-конструктор для создания экземпляра с обязательными параметрами
  factory MyItemModel.itemPro(Map<String, dynamic> prodItem) {
    {
      return MyItemModel(
        discountN: prodItem['hasDiscount'],
        prodImage: prodItem['image'],
        priceAfterDiscount: prodItem['discountPrice'],
        price: prodItem['price'],
        prodName: prodItem['productName'],
      );
    }
  }
}
