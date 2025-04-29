import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:internet_shop/pages/log_pages/register_page.dart';
import 'package:internet_shop/pages/navbottomBar/navigationPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obsecure = true;
  var storage = FlutterSecureStorage();

  var emailOrPhoneNumController = TextEditingController(text: 'string12');
  var passwordController = TextEditingController(text: 'string12');

  Future<void> login(emailOrPhone, password) async {
    try {
      var response = await http.post(
        Uri.parse('https://store-api.softclub.tj/Account/login'),

        headers: <String, String>{
          'Content-Type': 'application/json; CharSet=UTF-8',
          'Accept': 'application/json',
        },

        body: jsonEncode({'userName': emailOrPhone, 'password': password}),
      );

      if (response.statusCode == 200) {

        var token=jsonDecode(response.body)['data'];
        await storage.write(key: 'token', value: token);
        // print(token);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(response.body)));
        // print(response.body);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Navigationpage()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(response.body)));
        // print(response.body);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Log in to Exclusive', style: TextStyle(fontSize: 38)),

                    Text(
                      'Enter your details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 55),

                Container(
                  width: 400,
                  child: TextField(
                    controller: emailOrPhoneNumController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 5,
                      ),
                      hintText: 'Email or Phone Number',
                      labelText: 'Email or Phone Number',
                      labelStyle: TextStyle(color: Colors.grey),
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 25),
                Container(
                  width: 400,
                  child: TextField(
                    controller: passwordController,
                    obscureText: _obsecure,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 5,
                      ),

                      hintText: 'Password',
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obsecure = !_obsecure;
                          });
                        },
                        icon:
                            _obsecure
                                ? Icon(Icons.visibility_off, color: Colors.grey)
                                : Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.grey,
                                ),
                      ),
                      labelStyle: TextStyle(color: Colors.grey),
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Center(
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Center(
                  child:TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                  }, 
                  child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),)
                     
                  
                ),
                SizedBox(height: 30),

                Container(
                  width: 400,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        login(
                          emailOrPhoneNumController.text,
                          passwordController.text,
                        );
                      });
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 235, 68, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Log in',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
