import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shopping_app/screens/cart/controller/cartcontroller.dart';
import 'package:furniture_shopping_app/screens/home/controller/homecontroller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/firebase_helper.dart';
import '../../home/model/homemodel.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  HomeController homeController = Get.put(HomeController());
  CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {

    List<HomeModel> cartList = [];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text('My cart',style: GoogleFonts.overpass(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.w500)),
        ),
        body: StreamBuilder(
          stream: FirebaseHelper.firebaseHelper.readDataFromAddToCart(),
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
                    adminId: data['adminId'],
                    name: data['name'],
                    price: data['price'],
                    description: data['description'],
                    img: data['img'],
                    stock: data['stock'],
                    rating: data['rating'],
                    categoryId: data['categoryId'],
                    quantity: data['quantity'],
                    userId: '${homeController.userId.value}',
                );

                cartController.total.value = cartController.total.value + (h1.price!*h1.quantity!);
                cartList.add(h1);
                homeController.productList.add(h1);
              }
              return Stack(
                children: [
                  Container(
                    height: 80.h,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(itemBuilder: (context, index) => favouriteBox(
                      homeController.productList[index].img!,
                      homeController.productList[index].name!,
                      homeController.productList[index].price!,
                      homeController.productList[index].quantity!,
                      homeController.productList[index].description!,
                      homeController.productList[index].productId!,
                    ),itemCount: homeController.productList.length,),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Container(
                          margin: EdgeInsets.only(left: 15,right: 15,),
                          //margin: EdgeInsets.all(10),
                          height: 7.h,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // borderRadius: BorderRadius.circular(50),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total :',style: GoogleFonts.overpass(color: Colors.grey,fontWeight: FontWeight.w500,letterSpacing: 1,fontSize: 15.sp)),

                              // AnimatedFlipCounter(
                              //   duration: Duration(milliseconds: 300),
                              //   value: cartController.total.value,
                              //   fractionDigits: 2, // decimal precision
                              //   suffix: "/-",
                              //   textStyle: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,letterSpacing: 1,fontSize: 18.sp),
                              // )

                              Obx(() => Text('\$ ${cartController.total.value}/-',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,letterSpacing: 1,fontSize: 14.sp))),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {


                            for(int i=0; i<cartList.length; i++)
                              {
                                Map<String, dynamic> m1 = {
                                  'adminId' : cartList[i].adminId,
                                  'name' : cartList[i].name,
                                  'price' : cartList[i].price,
                                  'quantity': cartList[i].quantity,
                                  'img' : cartList[i].img,
                                  'stock' : cartList[i].stock,
                                  'rating' : cartList[i].rating,
                                  'description' : cartList[i].description,
                                  'categoryId' : cartList[i].categoryId,
                                };
                                print('${m1['adminId']}----admin id ');
                                FirebaseHelper.firebaseHelper.checkOutProduct(m1);
                              }

                            Get.toNamed('/checkout',arguments: cartList);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 15,right: 15,bottom: 20),
                            height: 6.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text('Check out',style: GoogleFonts.overpass(color: Colors.white,letterSpacing: 1,fontSize: 13.sp)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),


      ),
    );
  }

  Widget favouriteBox(String img, String pname, int price,int quantity, String desc ,String docId)
  {
    return Container(
      margin: EdgeInsets.all(10),
      height: 18.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        //color: Colors.black12
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 14.h,
                width: 30.w,
                child: ClipRRect(borderRadius: BorderRadius.circular(15),child: Image.network('${img}',fit: BoxFit.cover)),
              ),
              SizedBox(width: 4.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 1.h,),
                  Text(
                    '${pname}',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(color: Colors.black87,fontSize: 12.sp),
                  ),
                  SizedBox(height: 1.h,),
                  Text(
                    '\$ ${(price)*quantity}',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(color: Colors.black,fontSize: 14.sp,fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 0.5.h,),
                  Row(
                    children: [
                      Text(
                        'Qty : ',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(color: Colors.black,fontSize: 12.sp,fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${quantity}',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(color: Colors.black,fontSize: 12.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.5.h,),
                  Container(
                    width: 49.w,
                    child: Text(
                      '${desc}',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(color: Colors.grey,fontSize: 10.sp),
                    ),
                  ),
                ],
              ),
              Spacer(),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(onTap: () {
                  cartController.total.value = 0;
                  FirebaseHelper.firebaseHelper.deleteCartData(docId);
                },child: Icon(Icons.close,size: 16.sp,color: Colors.black)),
              ),
              SizedBox(width: 1.w,),
            ],
          ),
          SizedBox(height: 1.h,),
          Divider(),
        ],
      ),
    );
  }
}
