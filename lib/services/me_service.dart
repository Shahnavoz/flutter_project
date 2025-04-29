import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:internet_shop/models/me_model.dart';

class MeService {
  var storage = FlutterSecureStorage();

  Future<List<MeModel>> getUserInfoFromBack() async {
    try {
      var token = await storage.read(key: 'token');
      var response = await http.get(
        Uri.parse(
          'https://store-api.softclub.tj/UserProfile/get-user-profiles',
        ),

        headers: <String, String>{
          'Content-Type': 'application/json, charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return gettingInfo(response.body);
      } else {
        return List.empty();
      }
    } catch (e) {
      return [];
    }
  }
}
