import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shopping_app/screens/detail/controller/detailcontroller.dart';
import 'package:furniture_shopping_app/screens/home/controller/homecontroller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/firebase_helper.dart';
import '../../home/model/homemodel.dart';

class Detailscreen extends StatefulWidget {
  const Detailscreen({Key? key}) : super(key: key);

  @override
  State<Detailscreen> createState() => _DetailscreenState();
}

class _DetailscreenState extends State<Detailscreen> {
  HomeController homeController = Get.put(HomeController());
  DetailController detailController = Get.put(DetailController());


  HomeModel h1 = HomeModel();
  @override
  void initState() {
    super.initState();
    detailController.productPrice.value = 0;
    detailController.productQuantity.value = 1;

    h1 = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    print('detail product index ${detailController.productIndex.value}');
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // product image
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(padding: EdgeInsets.only(left: 4.w,top: 2.h),child: InkWell(onTap: () {
                    Get.back();
                  },child: Icon(Icons.arrow_back_ios_rounded,color: Colors.black,size: 25.sp))),
                  Spacer(),
                  Container(
                    height: 50.h,
                    width: 75.w,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(60)),
                      color: Colors.greenAccent,
                    ),
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(60)),
                      child: Image.network(
                        '${h1.img}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(18.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // product name
                    Text(
                      '${h1.name}',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(color: Colors.black,fontSize: 20.sp),
                    ),
                    SizedBox(height: 1.h,),
                    // amount line
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Obx(
                          () =>  Text(
                            '\$ ${(h1.price)!*detailController.productQuantity.value}',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(color: Colors.black,fontSize: 28.sp,fontWeight: FontWeight.w500),
                          ),
                        ),
                        // inc dec row button
                        Container(
                          height: 5.h,
                          width: 35.w,
                          //color: Colors.black12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  detailController.incrementQuantity();
                                },
                                child: Container(
                                  height: 4.h,
                                  width: 9.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black12,
                                  ),
                                  child: Icon(Icons.add,color: Colors.black,size: 15.sp),
                                ),
                              ),
                              Obx(() => Text('${detailController.productQuantity.value}',style: TextStyle(fontSize: 17.sp,color: Colors.black,fontWeight: FontWeight.w500),)),
                              InkWell(
                                onTap: () {
                                  detailController.decrementQuantity();
                                },
                                child: Container(
                                    height: 4.h,
                                    width: 9.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black12,
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(Icons.remove_sharp,color: Colors.black,size: 15.sp,)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    // rating
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.star,color: Colors.amber,size: 15.sp),
                        SizedBox(width: 2.w),
                        Text(
                          '${h1.rating}.8',
                          style: GoogleFonts.poppins(color: Colors.black,fontSize: 10.sp,fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '(43 reviews)',
                          style: GoogleFonts.poppins(color: Colors.grey,fontSize: 8.sp),
                        ),
                      ],
                    ),
                    // all detail paragraph
                    SizedBox(height: 1.h,),
                    Text(
                      '${h1.description}',
                      style: GoogleFonts.poppins(color: Colors.grey,fontSize: 10.sp),
                    ),
                    // save and add to cart box
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 6.h,
                      width: 16.w,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.bookmark_border,color: Colors.black45,size: 20.sp,),
                    ),
                    SizedBox(width: 5.w,),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Map<String, dynamic> m1 = {
                            'name' : h1.name,
                            'price' : h1.price,
                            'quantity': detailController.productQuantity.value,
                            'img' : h1.img,
                            'stock' : h1.stock,
                            'rating' : h1.rating,
                            'description' : h1.description,
                            'categoryId' : h1.categoryId,
                          };
                          FirebaseHelper.firebaseHelper.addToCartProduct(m1);
                          Get.back();
                        },
                        child: Container(
                          height: 6.h,
                          width: 10.w,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text('Add to cart',style: GoogleFonts.overpass(color: Colors.white,letterSpacing: 1,fontSize: 13.sp)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // StreamBuilder(
        //   stream: FirebaseHelper.firebaseHelper.readProductData(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       return Text('${snapshot.error}');
        //     } else if (snapshot.hasData) {
        //       QuerySnapshot? querySnapshot = snapshot.data;
        //       homeController.productList.clear();
        //       for (var x in querySnapshot!.docs) {
        //         Map data = x.data() as Map;
        //         HomeModel h1 = HomeModel(
        //             productId: x.id,
        //             name: data['name'],
        //             price: data['price'],
        //             description: data['description'],
        //             img: data['img'],
        //             stock: int.parse(data['stock']),
        //             rating: int.parse(data['rating']),
        //             categoryId: data['categoryId'],
        //             userId: '${homeController.userId.value}');
        //
        //         homeController.productList.add(h1);
        //       }
        //       return  Container(
        //         height: MediaQuery.of(context).size.height,
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             // product image
        //             Row(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               mainAxisAlignment: MainAxisAlignment.end,
        //               children: [
        //                Padding(padding: EdgeInsets.only(left: 4.w,top: 2.h),child: InkWell(onTap: () {
        //                  Get.back();
        //                },child: Icon(Icons.arrow_back_ios_rounded,color: Colors.black,size: 25.sp))),
        //                 Spacer(),
        //                 Obx(
        //                   () => Container(
        //                     height: 50.h,
        //                     width: 75.w,
        //                     decoration: BoxDecoration(
        //                       borderRadius:
        //                           BorderRadius.only(bottomLeft: Radius.circular(60)),
        //                       color: Colors.greenAccent,
        //                     ),
        //                     child: ClipRRect(
        //                       borderRadius:
        //                           BorderRadius.only(bottomLeft: Radius.circular(60)),
        //                       child: Image.network(
        //                         '${homeController.productList[detailController.productIndex.value].img}',
        //                         fit: BoxFit.cover,
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             Obx(
        //               () => Container(
        //                 margin: EdgeInsets.all(18.sp),
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     // product name
        //                     Text(
        //                       '${homeController.productList[detailController.productIndex.value].name}',
        //                       overflow: TextOverflow.ellipsis,
        //                       style: GoogleFonts.poppins(color: Colors.black,fontSize: 20.sp),
        //                     ),
        //                     SizedBox(height: 1.h,),
        //                     // amount line
        //                     Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //
        //                       children: [
        //                         Text(
        //                           '\$ ${(homeController.productList[detailController.productIndex.value].price)!*detailController.productQuantity.value}',
        //                           overflow: TextOverflow.ellipsis,
        //                           style: GoogleFonts.poppins(color: Colors.black,fontSize: 28.sp,fontWeight: FontWeight.w500),
        //                         ),
        //                         // inc dec row button
        //                         Container(
        //                           height: 5.h,
        //                           width: 35.w,
        //                           //color: Colors.black12,
        //                           child: Row(
        //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                             children: [
        //                               InkWell(
        //                                 onTap: () {
        //                                   detailController.incrementQuantity();
        //                                 },
        //                                 child: Container(
        //                                   height: 4.h,
        //                                   width: 9.w,
        //                                   decoration: BoxDecoration(
        //                                     borderRadius: BorderRadius.circular(10),
        //                                     color: Colors.black12,
        //                                   ),
        //                                   child: Icon(Icons.add,color: Colors.black,size: 15.sp),
        //                                 ),
        //                               ),
        //                               Obx(() => Text('${detailController.productQuantity.value}',style: TextStyle(fontSize: 17.sp,color: Colors.black,fontWeight: FontWeight.w500),)),
        //                               InkWell(
        //                                 onTap: () {
        //                                   detailController.decrementQuantity();
        //                                 },
        //                                 child: Container(
        //                                   height: 4.h,
        //                                   width: 9.w,
        //                                   decoration: BoxDecoration(
        //                                     borderRadius: BorderRadius.circular(10),
        //                                     color: Colors.black12,
        //                                   ),
        //                                   alignment: Alignment.center,
        //                                   child: Icon(Icons.remove_sharp,color: Colors.black,size: 15.sp,)
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                     SizedBox(height: 1.h,),
        //                     // rating
        //                     Row(
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       children: [
        //                         Icon(Icons.star,color: Colors.amber,size: 15.sp),
        //                         SizedBox(width: 2.w),
        //                         Text(
        //                           '${homeController.productList[detailController.productIndex.value].rating}.8',
        //                           style: GoogleFonts.poppins(color: Colors.black,fontSize: 10.sp,fontWeight: FontWeight.w500),
        //                         ),
        //                         SizedBox(width: 4.w),
        //                         Text(
        //                           '(43 reviews)',
        //                           style: GoogleFonts.poppins(color: Colors.grey,fontSize: 8.sp),
        //                         ),
        //                       ],
        //                     ),
        //                     // all detail paragraph
        //                     SizedBox(height: 1.h,),
        //                     Text(
        //                       '${homeController.productList[detailController.productIndex.value].description}',
        //                       style: GoogleFonts.poppins(color: Colors.grey,fontSize: 10.sp),
        //                     ),
        //                     // save and add to cart box
        //                   ],
        //                 ),
        //               ),
        //             ),
        //             Spacer(),
        //             Padding(
        //               padding: const EdgeInsets.only(left: 20,right: 20,bottom: 8),
        //               child: Row(
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 children: [
        //                   Container(
        //                     height: 6.h,
        //                     width: 16.w,
        //                     decoration: BoxDecoration(
        //                       color: Colors.black12,
        //                       borderRadius: BorderRadius.circular(10),
        //                     ),
        //                     child: Icon(Icons.bookmark_border,color: Colors.black45,size: 20.sp,),
        //                   ),
        //                   SizedBox(width: 5.w,),
        //                   Expanded(
        //                     child: InkWell(
        //                       onTap: () {
        //                         Map<String, dynamic> m1 = {
        //                           'name' : homeController.productList[detailController.productIndex.value].name,
        //                           'price' : homeController.productList[detailController.productIndex.value].price,
        //                           'quantity': detailController.productQuantity.value,
        //                           'img' : homeController.productList[detailController.productIndex.value].img,
        //                           'stock' : homeController.productList[detailController.productIndex.value].stock,
        //                           'rating' : homeController.productList[detailController.productIndex.value].rating,
        //                           'description' : homeController.productList[detailController.productIndex.value].description,
        //                           'categoryId' : homeController.productList[detailController.productIndex.value].categoryId,
        //                         };
        //                         FirebaseHelper.firebaseHelper.addToCartProduct(m1);
        //                         Get.back();
        //                       },
        //                       child: Container(
        //                         height: 6.h,
        //                         width: 10.w,
        //                         decoration: BoxDecoration(
        //                           color: Colors.black,
        //                           borderRadius: BorderRadius.circular(10),
        //                         ),
        //                         alignment: Alignment.center,
        //                         child: Text('Add to cart',style: GoogleFonts.overpass(color: Colors.white,letterSpacing: 1,fontSize: 13.sp)),
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       );
        //     }
        //     return Center(child: CircularProgressIndicator());
        //   },
        // ),

      ),
    );
  }
}
