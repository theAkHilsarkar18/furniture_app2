import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shopping_app/screens/detail/controller/detailcontroller.dart';
import 'package:furniture_shopping_app/screens/home/controller/homecontroller.dart';
import 'package:furniture_shopping_app/screens/operation/controller/opcontroller.dart';
import 'package:furniture_shopping_app/utils/firebase_helper.dart';
import 'package:get/get.dart';

import '../../home/model/homemodel.dart';

class OperationScreen extends StatefulWidget {
  const OperationScreen({super.key});

  @override
  State<OperationScreen> createState() => _OperationScreenState();
}

class _OperationScreenState extends State<OperationScreen> {

  HomeController homeController = Get.put(HomeController());
  OpController opController = Get.put(OpController());
  DetailController detailController = Get.put(DetailController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(onPressed: () {
          // FirebaseHelper.firebaseHelper.addFurnitureData();
          //FirebaseHelper.firebaseHelper.deleteFurnitureData();
        },child: Icon(Icons.add),),
        body: Center(
          child: StreamBuilder(
            stream: FirebaseHelper.firebaseHelper.readProductData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                QuerySnapshot? querySnapshot = snapshot.data;
                homeController.productList.clear();
                for (var x in querySnapshot!.docs) {
                  Map data = x.data() as Map;
                  HomeModel h1 = HomeModel(
                      productId: x.id,
                      name: data['name'],
                      price: data['price'],
                      description: data['description'],
                      img: data['img'],
                      stock: int.parse(data['stock']),
                      rating: int.parse(data['rating']),
                      categoryId: data['categoryId'],
                      userId: '${homeController.userId.value}');

                  homeController.productList.add(h1);
                }
                return Text('');
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
