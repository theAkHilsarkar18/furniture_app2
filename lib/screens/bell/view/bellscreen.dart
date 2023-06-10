import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shopping_app/screens/home/controller/homecontroller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/firebase_helper.dart';
import '../../home/model/homemodel.dart';

class BellScreen extends StatefulWidget {
  const BellScreen({super.key});

  @override
  State<BellScreen> createState() => _BellScreenState();
}

HomeController homeController = Get.put(HomeController());

class _BellScreenState extends State<BellScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text('Notification',style: GoogleFonts.overpass(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.w500)),
        ),
        body: StreamBuilder(
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
              return ListView.builder(itemBuilder: (context, index) => notificationBox(
                  homeController.productList[index].img!
              ),itemCount: 5,);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),


      ),
    );
  }


  Widget notificationBox(String img)
  {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5.sp),
      height: 20.h,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 12.h,
                width: 27.w,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(borderRadius: BorderRadius.circular(15),child: Image.network('$img',fit: BoxFit.cover,)),
              ),
              SizedBox(width: 2.w,),
              Column(
                children: [
                  Container(padding: EdgeInsets.all(5),width: 60.w,child: Text('Your order #12354689 has been shipped successfully',style: GoogleFonts.overpass(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 11.sp))),
                  Container(padding: EdgeInsets.only(left: 5),width: 60.w,child: Text('Your payment is successfully done thanks for choose our app!',style: GoogleFonts.overpass(color: Colors.grey,fontSize: 10.sp))),
                  Container(padding: EdgeInsets.only(left: 5),width: 60.w,child: Text('New',style: GoogleFonts.overpass(color: Colors.green,fontWeight: FontWeight.w600,fontSize: 11.sp))),
                ],
              ),
                ],
          ),
          Divider(color: Colors.grey,thickness: 0.2),
        ],
      ),
    );
  }
}
