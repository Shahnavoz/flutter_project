import 'package:flutter/material.dart';
import 'package:internet_shop/models/cart_item.dart';
import 'package:internet_shop/models/my_item_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

List<MyItemModel> addingToCart = [];
List<CartItem>  cartItem=[];

class _CartPageState extends State<CartPage> {
  int kolichestvo = 1;

  void increment() {
    setState(() {
      kolichestvo++;
    });
  }

  void decrement() {
    setState(() {
      if (kolichestvo > 0) {
        kolichestvo--;
      }
    });
  }

  //
  // void addToCart(MyItemModel product, int count) {
  //   final existingItemIndex = cartItem.indexWhere(
  //     (item) => item.name == product.prodName,
  //   );

  //   if (existingItemIndex != -1) {
  //     cartItem[existingItemIndex].kol_vo += count;
  //   } else {
  //     cartItem.add(CartItem(name:'$product', kol_vo: count));
  //   }

  //   setState(() {}); // чтобы обновить UI
  // }

  //





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Center(
              child: Text('Cart Page', style: TextStyle(fontSize: 35)),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
                  child: Container(
                    width: double.infinity,
                    // height: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(-1, 1),
                          spreadRadius: 12,
                          color: Colors.grey[200]!,
                          blurRadius: 3
                        )
                      ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 90,
                                height: 130,
                                child: Image.network(
                                  'https://store-api.softclub.tj/images/${addingToCart[index].prodImage}',
                                  fit: BoxFit.cover,
                                ),
                              ),

                              SizedBox(width: 15),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 130,
                                    child: Text(
                                      addingToCart[index].prodName!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        
                                      ),
                                    ),
                                  ),
                                  // Spacer(),
                                  SizedBox(height: 25),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'TJS ${(addingToCart[index].price! * kolichestvo)}.00',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 7),

                                      Icon(
                                        Icons.favorite_border,
                                        size: 35,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                             IconButton(onPressed: (){}, icon:  Icon(Icons.close),),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height: 20),

                                  Text(
                                    '${addingToCart[index].price.toString()}/1',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(height: 25),

                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: FloatingActionButton(
                                              backgroundColor: Colors.white,
                                              onPressed: () {
                                                decrement();
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: SizedBox(
                                              child: Text(
                                                '$kolichestvo',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: FloatingActionButton(
                                              backgroundColor: Colors.white,
                                              onPressed: () {
                                                increment();
                                              },
                                              child: Icon(Icons.add, size: 25),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 0),
              itemCount: addingToCart.length,
            ),
          ),
        ],
      ),
    );
  }
}


// ListTile(
                    //   leading: Image.network(
                    //     'https://store-api.softclub.tj/images/${addingToCart[index].prodImage}',
                    //   ),
                    //   title: Text(addingToCart[index].prodName!, style: TextStyle(fontSize: 25)),
                    //   subtitle: Text(addingToCart[index].price.toString(), style: TextStyle(fontSize: 15)),
                    //   trailing: IconButton(onPressed: (){
                    //     setState(() {

                    //     addingToCart.removeAt(index);
                    //     });
                    //   }, icon: Icon(Icons.delete,color: Colors.red,)),
                    // ),
