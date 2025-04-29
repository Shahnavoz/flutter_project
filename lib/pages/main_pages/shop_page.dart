import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:internet_shop/components/carousel_page.dart';
import 'package:internet_shop/components/list_carousel_images.dart';
import 'package:internet_shop/models/cart_item.dart';
import 'package:internet_shop/models/category_model.dart';
import 'package:internet_shop/models/my_item_model.dart';
import 'package:internet_shop/pages/main_pages/cart_page.dart';
import 'package:internet_shop/services/category_service.dart';
import 'package:internet_shop/services/prod_service.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<MyItemModel> searchList = [];

  final searchController = TextEditingController();
  bool isLoaded = false;
  int kolichestvo = 1;

  void increment() {
    kolichestvo++;
  }

  void decrement() {
    if (kolichestvo > 1) {
      kolichestvo--;
    }
  }

  @override
  void initState() {
    super.initState();
    getProdItemsFromService();
    getCategoriesFromService();
  }

  List<MyItemModel> getSliderInfoFromBack = [];
  List<CategoryModel> Categories = [];

  getProdItemsFromService() async {
    var t = await ProdService().gettingSliderInfo();
    setState(() {
      isLoaded = true;
      getSliderInfoFromBack = t;
       searchList = getSliderInfoFromBack;
    });
  }

  getCategoriesFromService() async {
    var categItem = await CategoryService().getCategoriesFromBack();

    setState(() {
      Categories = categItem;
     
    });
  }

  //Adding to Cart
  void addToCart(MyItemModel product, int count) {
    final existingItemIndex = cartItem.indexWhere(
      (item) => item.name == product.prodName,
    );

    if (existingItemIndex != -1) {
      cartItem[existingItemIndex].kol_vo += count;
    } else {
      cartItem.add(CartItem(name: '$product', kol_vo: count));
    }

    setState(() {}); // чтобы обновить UI
  }

  //search function
  void filteredList(String searchedPro) {
    setState(() {
      searchList =
          getSliderInfoFromBack.where(
            (element) => element.prodName!.toLowerCase().contains(
              searchedPro.toLowerCase(),
            ),
          ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body:
          isLoaded == false
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 300,
                                child: TextField(
                                  controller: searchController,
                                  onChanged: (newValue) {
                                    filteredList(newValue);
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Поиск продуктов...',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    suffixIcon: Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    ),

                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 5,
                                    ),
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.add_alert_sharp),
                            ],
                          ),
                        ),

                        //CarouselSlider
                        CarouselSlider.builder(
                          itemCount: carouselImages.length,
                          itemBuilder: (context, index, newInd) {
                            return Container(
                              width: 300,
                              child: CarouselPage(image: carouselImages[index]),
                            );
                          },
                          options: CarouselOptions(autoPlay: true),
                        ),

                        //Categories
                        Text('Categories', style: TextStyle(fontSize: 20)),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 180,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(25),
                                      ),

                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Container(
                                          width: 90,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                          ),
                                          child: Image.network(
                                            'https://store-api.softclub.tj/images/${Categories[index].categImage}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${Categories[index].categName},',
                                      style: TextStyle(fontSize: 15),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder:
                                  (context, index) => SizedBox(width: 15),
                              itemCount: Categories.length,
                            ),
                          ),
                        ),

                        //Prodagha
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Хит Продажи',
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Text('All Products'),
                                  Icon(Icons.arrow_forward_ios_sharp),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: SizedBox(
                            height: 330,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(-1, 1),
                                        color: Colors.white,
                                        spreadRadius: 2,
                                        blurRadius: 1,
                                      ),
                                    ],
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 2,
                                                    ),
                                                child: Text(
                                                  searchList[index]
                                                              .discountN ==
                                                          true
                                                      ? '10 %'
                                                      : '0%',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            Icon(
                                              Icons.favorite_outline,
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),

                                        Image.network(
                                          height: 130,
                                          width: 100,
                                          'https://store-api.softclub.tj/images/${searchList[index].prodImage}',
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${searchList[index].priceAfterDiscount}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              Text(
                                                '${searchList[index].price}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          '${searchList[index].prodName}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),

                                        ElevatedButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) {
                                                return StatefulBuilder(
                                                  builder: (context, setState) {
                                                    return Container(
                                                      height:
                                                          MediaQuery.of(
                                                            context,
                                                          ).size.height *
                                                          0.7,

                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 15,
                                                            ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Center(
                                                              child: Image.network(
                                                                'https://store-api.softclub.tj/images/${searchList[index].prodImage}',
                                                                width: 170,
                                                                fit:
                                                                    BoxFit
                                                                        .cover,
                                                              ),
                                                            ),

                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  '${searchList[index].prodName}',
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        25,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                ),

                                                                SizedBox(
                                                                  height: 15,
                                                                ),

                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'Цена',
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '${searchList[index].price} .00 TJS',
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            23,
                                                                        color:
                                                                            Colors.blue,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),

                                                                SizedBox(
                                                                  height: 15,
                                                                ),

                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'Количество',
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                    ),

                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                        color:
                                                                            Colors.grey[300],
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              12,
                                                                            ),
                                                                      ),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10,
                                                                          vertical:
                                                                              8,
                                                                        ),
                                                                        child: Row(
                                                                          children: [
                                                                            SizedBox(
                                                                              width:
                                                                                  45,
                                                                              height:
                                                                                  45,
                                                                              child: FloatingActionButton(
                                                                                backgroundColor:
                                                                                    Colors.white,
                                                                                onPressed: () {
                                                                                  setState(
                                                                                    () {
                                                                                      decrement();
                                                                                    },
                                                                                  );
                                                                                },
                                                                                child: Icon(
                                                                                  Icons.remove,
                                                                                  size:
                                                                                      25,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.symmetric(
                                                                                horizontal:
                                                                                    10,
                                                                              ),
                                                                              child: SizedBox(
                                                                                child: Text(
                                                                                  '$kolichestvo',
                                                                                  style: TextStyle(
                                                                                    fontSize:
                                                                                        20,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width:
                                                                                  45,
                                                                              height:
                                                                                  45,
                                                                              child: FloatingActionButton(
                                                                                backgroundColor:
                                                                                    Colors.white,
                                                                                onPressed: () {
                                                                                  setState(
                                                                                    () {
                                                                                      increment();
                                                                                    },
                                                                                  );
                                                                                },
                                                                                child: Icon(
                                                                                  Icons.add,
                                                                                  size:
                                                                                      25,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),

                                                                SizedBox(
                                                                  height: 25,
                                                                ),

                                                                Container(
                                                                  // height: 450,
                                                                  width:
                                                                      double
                                                                          .infinity,
                                                                  child: ElevatedButton(
                                                                    onPressed: () {
                                                                      addingToCart
                                                                          .add(
                                                                            searchList[index],
                                                                          );

                                                                      Navigator.pop(
                                                                        context,
                                                                      );
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .blue,
                                                                    ),
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.symmetric(
                                                                        vertical:
                                                                            15,
                                                                      ),
                                                                      child: Text(
                                                                        'В корзину',
                                                                        style: TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey[300],
                                            elevation: 0,
                                          ),
                                          child: Text(
                                            'В корзину',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (context, index) => SizedBox(width: 20),
                              itemCount: searchList.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }
}
