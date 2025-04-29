import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:internet_shop/models/my_item_model.dart';



class ProdService {
   var storage = FlutterSecureStorage();
  Future<List<MyItemModel>> gettingSliderInfo() async {
    try {
      var token = await storage.read(key: 'token');
      var response = await http.get(
        Uri.parse('https://store-api.softclub.tj/Product/get-products'),

        headers: <String, String>{
          'Content-Type': 'application/json, Charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if(response.statusCode == 200)
      {
        return getProItemsFromBack(response.body);
        // getSliderInfoFromBack=jsonDecode(response.body)['data'];
      }
      else{
        // throw Exception();
        return List.empty();
      }
    } catch (e) {
      // print(e);
      return [];
    
    }
  }
}