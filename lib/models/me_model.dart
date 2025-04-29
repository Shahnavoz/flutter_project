
import 'dart:convert';

List<MeModel> gettingInfo(response)
{
  var fromJson=jsonDecode(response)['data'];

  return List.from(fromJson.map((item)=>MeModel.userInfo(item)));
}

class MeModel {
  final String userName;
  final String userImage;
  final String userLastName;

  MeModel({
    required this.userName,
    required this.userImage,
    required this.userLastName,
  });

  factory MeModel.userInfo(Map<String, dynamic> userInfoFromJson) {
    return MeModel(
      userName: userInfoFromJson['userName'],
      userImage: userInfoFromJson['image'],
      userLastName: userInfoFromJson['lastName'],
    );
  }
}
