import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shopping_app/screens/cart/controller/cartcontroller.dart';
import 'package:furniture_shopping_app/screens/detail/controller/detailcontroller.dart';
import 'package:furniture_shopping_app/screens/profile/controller/profilecontroller.dart';
import 'package:furniture_shopping_app/screens/signin_signup/controller/signupcontroller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/firebase_helper.dart';
import '../controller/homecontroller.dart';
import '../model/homemodel.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

HomeController homeController = Get.put(HomeController());

class _HomescreenState extends State<Homescreen> {
  DetailController detailController = Get.put(DetailController());
  ProfileController  profileController = Get.put(ProfileController());
  SignupController signupController = Get.put(SignupController());
  CartController cartController = Get.put(CartController());
  List<HomeModel> favList  = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.getUserDetail();

  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // appbar search bar cart icon
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, bottom: 10, top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(onTap: () {
                    
                  },child: Icon(Icons.search,color: Colors.grey,size: 21.sp,)),
                  Column(
                    children: [
                      Text(
                        'MAKE HOME',
                        style: GoogleFonts.overpass(
                            color: Colors.grey, fontSize: 10.sp),
                      ),
                      Text(
                        'BEAUTIFUL',
                        style: GoogleFonts.overpass(
                            color: Colors.black54,
                            fontSize: 14.sp,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  InkWell(onTap: () {
                    cartController.total.value = 0;
                    Get.toNamed('/cart');
                  },child: Icon(Icons.shopping_cart_outlined,color: Colors.grey,size: 20.sp,)),
                ],
              ),
            ),
            // category filter selected
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 5),
                  height: 11.h,
                  width: 20.w,
                  color: Colors.white,
                  child: favouriteBox(
                      Icon(
                        Icons.favorite,
                        color: Colors.black,
                        size: 18.sp,
                      ),
                      'Favourite'),
                ),
                Expanded(
                  child: Container(
                      height: 11.h,
                      alignment: Alignment.center,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => categoryBox(
                          homeController.categoryList[index],
                          homeController.categoryNameList[index],
                        ),
                        itemCount: homeController.categoryList.length,
                        scrollDirection: Axis.horizontal,
                      )),
                ),
              ],
            ),



            // product grid view
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 8,right: 8,top: 10),
                height: 68.h,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                  stream: FirebaseHelper.firebaseHelper.readProductData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else if (snapshot.hasData) {
                      QuerySnapshot? querySnapshot = snapshot.data;

                      List<HomeModel> productList = [];
                      for (var x in querySnapshot!.docs) {
                        Map data = x.data() as Map;
                        HomeModel h1 = HomeModel(
                          adminId: data['adminId'],
                            productId: x.id,
                            name: data['name'],
                            price: data['price'],
                            description: data['description'],
                            img: data['img'],
                            stock: int.parse(data['stock']),
                            rating: int.parse(data['rating']),
                            categoryId: data['categoryId'],
                            userId: '${homeController.userId.value}');
                        favList.add(h1);
                        productList.add(h1);
                      }
                       return GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10.sp,
                          mainAxisSpacing: 10.sp,
                          childAspectRatio: 9/16,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            // detailController.productIndex.value = index;
                            // print('product index ${detailController.productIndex.value}');

                            Get.toNamed('/detail',arguments: productList[index]);
                          },
                          child: productBox(
                            index,
                            productList[index].name!,
                            productList[index].img!,
                            productList[index].price!,
                            productList[index].rating!,
                          ),
                        ),
                        itemCount: productList.length,
                      );

                      // return ListView.builder(itemBuilder: (context, index) => Text('data'),itemCount: 5,);
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),

              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget productBox(int i,String pName,String pImg, int price, int rating) {
    return Container(
      //color: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 2,),
          Stack(
            children: [
              Container(height: 29.h, width: 44.w, child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network('$pImg',fit: BoxFit.cover,))),
              Transform.translate(offset: Offset(34.w, 24.5.h),child: Container(
                height: 4.5.h,
                  width: 10.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10)
                    ),
                  ),
                  child: InkWell(onTap: () async {

                    Map<String, dynamic> m1 = {
                      'name' : favList[i].name,
                      'price' : favList[i].price,
                      'quantity': 1,
                      'img' : favList[i].img,
                      'stock' : favList[i].stock,
                      'rating' : favList[i].rating,
                      'description' : favList[i].description,
                      'categoryId' : favList[i].categoryId,
                      'adminId' : favList[i].adminId,
                    };
                    await FirebaseHelper.firebaseHelper.addToFavourites(m1);
                  },child: Icon(Icons.favorite,color: Colors.black,size: 15.sp,))),),
            ],
          ),
          SizedBox(height: 1.h,),
          Container(
            width: 50.w,
            margin: EdgeInsets.only(left: 10, right: 10),
            //color: Colors.amber,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('$pName',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.overpass(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp)),
                SizedBox(height: 2,),
                Container(
                  height: 4.h,
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Text('\$ $price',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.overpass(
                              color: Colors.black, fontWeight: FontWeight.bold,fontSize: 12.sp)),
                      Spacer(),
                      Text('$rating.8',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.overpass(
                              color: Colors.black, fontWeight: FontWeight.w500,fontSize: 11.sp)),
                      SizedBox(width: 1,),
                      Icon(Icons.star,size: 13.sp,color: Colors.amber,)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget favouriteBox(Icon i1, String name) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.all(10),
            height: 6.h,
            width: 14.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15),
            ),
            child: i1),
        Text(
          '$name',
          style: GoogleFonts.overpass(
              color: Colors.black, fontWeight: FontWeight.w500,fontSize: 10.sp),
        ),
      ],
    );
  }

  Widget categoryBox(Icon i1, String name) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.all(10),
            height: 6.h,
            width: 14.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15),
            ),
            child: i1),
        Text(
          '$name',
          style: GoogleFonts.overpass(
              color: Colors.grey, fontWeight: FontWeight.w500,fontSize: 9.sp),
        ),
      ],
    );
  }
}
