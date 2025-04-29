import 'package:flutter/material.dart';
import 'package:internet_shop/components/subcatagories.dart';
import 'package:internet_shop/pages/log_pages/login_page.dart';
import 'package:internet_shop/pages/log_pages/register_page.dart';
import 'package:internet_shop/pages/main_pages/cart_page.dart';
import 'package:internet_shop/pages/navbottomBar/navigationPage.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigationpage(),
    );
  }
}