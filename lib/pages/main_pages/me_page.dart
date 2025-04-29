import 'package:flutter/material.dart';
import 'package:internet_shop/models/me_model.dart';
import 'package:internet_shop/services/me_service.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  List<MeModel> userInfoList = [];

  @override
  void initState() {
    super.initState();
    gettingFromService();
  }

  gettingFromService() async {
    var user = await MeService().getUserInfoFromBack();

    setState(() {
      userInfoList = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      shape: BoxShape.circle
                    ),
                    child: Icon(Icons.person,size: 50,),
                  ),

                  SizedBox(width: 20,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text('UserName',style: TextStyle(fontSize: 25,fontStyle: FontStyle.italic),),
                    Text('UserLastName',style: TextStyle(fontSize: 20,),)
                  ],)
                ],
                      
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(border: Border.all(),shape: BoxShape.circle),
                          child: ClipOval(
                            // radius: 30,
                            child:
                                userInfoList[index].userImage.isEmpty
                                    ? Icon(Icons.person)
                                    : Image.network(
                                      'https://store-api.softclub.tj/images/${userInfoList[index].userImage}',
                                    ),
                          ),
                        ),
                        title: Text(
                          userInfoList[index].userName.isEmpty
                              ? 'UserName'
                              : userInfoList[index].userName,
                          style: TextStyle(fontSize: 25),
                        ),
                        subtitle: Text(
                          userInfoList[index].userLastName.isEmpty
                              ? 'UserLastName'
                              : userInfoList[index].userLastName,
                          style: TextStyle(fontSize: 15),
                        ),
                        trailing: Icon(Icons.delete,size: 35,),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 0),
                itemCount: userInfoList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
