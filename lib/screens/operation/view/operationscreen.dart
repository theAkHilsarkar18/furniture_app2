import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shopping_app/screens/operation/controller/opcontroller.dart';
import 'package:furniture_shopping_app/utils/firebase_helper.dart';
import 'package:get/get.dart';

class OperationScreen extends StatefulWidget {
  const OperationScreen({super.key});

  @override
  State<OperationScreen> createState() => _OperationScreenState();
}

class _OperationScreenState extends State<OperationScreen> {

  OpController opController = Get.put(OpController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          // FirebaseHelper.firebaseHelper.addFurnitureData();
          FirebaseHelper.firebaseHelper.deleteFurnitureData();
        },child: Icon(Icons.add),),
        body: Center(
          child: StreamBuilder(
            stream: FirebaseHelper.firebaseHelper.readFurnitureData(),
            builder: (context, snapshot) {
              if(snapshot.hasError)
                {
                  return Text('${snapshot.error}');
                }
              else if(snapshot.hasData)
                {
                  QuerySnapshot? querySnapshot = snapshot.data;
                  for(var x in querySnapshot!.docs)
                    {
                      Map data = x.data() as Map;
                      opController.docId.value = x.id;
                      return Text('${opController.docId.value}');
                    }
                }
                  return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
