import 'dart:math';

import 'package:flutter/material.dart';

class CarouselPage extends StatefulWidget {
  final String image;
  const CarouselPage({super.key,required this.image});

  @override
  State<CarouselPage> createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 300,
        height: 200,
        decoration: BoxDecoration(
          image:DecorationImage(image:AssetImage('${widget.image}',),fit:BoxFit.cover),
          borderRadius: BorderRadius.circular(20),
          ),
      ),
    );
  }
}
