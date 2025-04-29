import 'dart:convert';

import 'package:internet_shop/models/subcategs_model.dart';

List<CategoryModel> gettingCategsFromBack(response)
{
  var fromJson = jsonDecode(response)['data'];

  return List.from(fromJson.map((eachCateg)=>CategoryModel.Categs(eachCateg)));
}


class CategoryModel {
  String categImage;
  String categName;
  List<SubcategsModel> subCategories;

  CategoryModel({required this.categImage, required this.categName, required this.subCategories});

  factory CategoryModel.Categs(Map<String, dynamic> categsFromBack) {
    return CategoryModel(
      categImage: categsFromBack['categoryImage'],
      categName: categsFromBack['categoryName'],
      subCategories: gettingsubCategsFromBack(categsFromBack['subCategories']) ,
    );
  }
}
