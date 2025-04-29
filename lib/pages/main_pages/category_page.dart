import 'package:flutter/material.dart';
import 'package:internet_shop/components/subcatagories.dart';
import 'package:internet_shop/models/category_model.dart';
import 'package:internet_shop/services/category_service.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  bool isLoading=false;
   List<CategoryModel> Categories = [];

   @override
   void initState() {
     super.initState();
     getCategoriesFromService();
   }

    getCategoriesFromService() async {
    var categItem = await CategoryService().getCategoriesFromBack();

    setState(() {
      Categories = categItem;
      isLoading = true;
    });
  }

  void navigateToEachPage(int index)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Subcatagories(
      subCategories: Categories[index].subCategories,

    )));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body:isLoading == false ? Center(child: CircularProgressIndicator()) : SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Container(
                width: double.infinity,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Поиск категория...',
                    hintStyle: TextStyle(color: Colors.grey),
                    suffixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 5,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
            //////////
            Expanded(
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => navigateToEachPage(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('${Categories[index].categName}'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    Image.network(
                                      width:95,
                                      height: 65,
                                      'https://store-api.softclub.tj/images/${Categories[index].categImage}',
                                    
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                      ),
                    ),
                  );
                },
                itemCount: Categories.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
