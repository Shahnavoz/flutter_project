import 'dart:convert';

List<SubcategsModel> gettingsubCategsFromBack(listOFSubCategories) {
  final List<SubcategsModel> allSubCategories = [];

  final List<dynamic> subCats = listOFSubCategories;
  allSubCategories.addAll(
    subCats.map((e) => SubcategsModel.Categs(e)).toList(),
  );

  return allSubCategories;
}

class SubcategsModel {
  String subcategsName;
  int id;

  SubcategsModel({required this.subcategsName, required this.id});

  factory SubcategsModel.Categs(Map<String, dynamic> subcategsFromBack) {
    return SubcategsModel(
      subcategsName: subcategsFromBack['subCategoryName'],
      id: subcategsFromBack['id'],
    );
  }
}
