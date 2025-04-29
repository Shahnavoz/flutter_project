
import 'package:flutter/material.dart';
import 'package:internet_shop/models/subcategs_model.dart';

class Subcatagories extends StatefulWidget {
  final List<SubcategsModel> subCategories;
  const Subcatagories({super.key, required this.subCategories});

  @override
  State<Subcatagories> createState() => _SubcatagoriesState();
}

class _SubcatagoriesState extends State<Subcatagories> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SafeArea(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue[700]!),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Text('${widget.subCategories[index].id}',style: TextStyle(fontSize: 16,color: Colors.blue),),
                    title: Text(widget.subCategories[index].subcategsName,style: TextStyle(fontSize: 20,color: const Color.fromARGB(255, 29, 113, 155)),),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 20),
            itemCount: widget.subCategories.length,
          ),
        ),
      ),
    );
  }
}
