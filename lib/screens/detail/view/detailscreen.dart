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
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // product image
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 4.w, top: 2.h),
                      child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back_ios_rounded,
                              color: Colors.black, size: 25.sp))),
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
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 20.sp),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    // amount line
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                            '\$ ${(h1.price)! * detailController.productQuantity.value}',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500),
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
                                  child: Icon(Icons.add,
                                      color: Colors.black, size: 15.sp),
                                ),
                              ),
                              Obx(() => Text(
                                    '${detailController.productQuantity.value}',
                                    style: TextStyle(
                                        fontSize: 17.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  )),
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
                                    child: Icon(
                                      Icons.remove_sharp,
                                      color: Colors.black,
                                      size: 15.sp,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    // rating
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 15.sp),
                        SizedBox(width: 2.w),
                        Text(
                          '${h1.rating}.8',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '(43 reviews)',
                          style: GoogleFonts.poppins(
                              color: Colors.grey, fontSize: 8.sp),
                        ),
                      ],
                    ),
                    // all detail paragraph
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      '${h1.description}',
                      style: GoogleFonts.poppins(
                          color: Colors.grey, fontSize: 10.sp),
                    ),
                    // save and add to cart box
                  ],
                ),
              ),
              // product description
              // offer row
              Column(
                children: [
                  Padding(
                   padding : const EdgeInsets.only(left: 20, right: 20, bottom: 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.percent,
                          color: Colors.amber,
                          size: 20.sp,
                        ),
                        SizedBox(width: 2.w,),
                        Text('Offers',style: GoogleFonts.poppins(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  offerBox(),
                ],
              ),
              // facilty box
              faciltyBox(),
              // product detail
              detailBox(),
              // product review
              reviewBox(),
              SizedBox(height: 1.h,),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20, right: 20, bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        Map<String, dynamic> m1 = {
                          'adminId': h1.adminId,
                          'name': h1.name,
                          'price': h1.price,
                          'quantity': detailController.productQuantity.value,
                          'img': h1.img,
                          'stock': h1.stock,
                          'rating': h1.rating,
                          'description': h1.description,
                          'categoryId': h1.categoryId,
                        };

                        await FirebaseHelper.firebaseHelper
                            .addToFavourites(m1);
                      },
                      child: Container(
                        height: 6.h,
                        width: 15.w,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.bookmark_border,
                          color: Colors.black45,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          Map<String, dynamic> m1 = {
                            'name': h1.name,
                            'price': h1.price,
                            'quantity':
                                detailController.productQuantity.value,
                            'img': h1.img,
                            'stock': h1.stock,
                            'rating': h1.rating,
                            'description': h1.description,
                            'categoryId': h1.categoryId,
                            'adminId': h1.adminId,
                          };
                          await FirebaseHelper.firebaseHelper
                              .addToCartProduct(m1);
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
                          child: Text('Add to cart',
                              style: GoogleFonts.overpass(
                                  color: Colors.white,
                                  letterSpacing: 1,
                                  fontSize: 13.sp)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h,),
            ],
          ),
        ),
      ),
    );
  }

  Widget offerBox() {
    return Padding(
      padding: EdgeInsets.only(left: 15.sp,top: 10.sp,right: 15.sp,bottom: 10.sp),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          children: [
            Container(
              height: 16.h,
              width: 45.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.sp),
                border: Border.all(color: Colors.grey.shade400)
              ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('No Cost EMI',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 11.sp)),
                  SizedBox(height: 0.5.h,),
                  Text('Upto ₹1,285.15 EMI interest savings on select Credit Cards…',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 10.sp)),
                  SizedBox(height: 0.5.h,),
                  Text('2 offers >',style: TextStyle(color: Colors.teal,fontWeight: FontWeight.w400,fontSize: 10.sp)),

                ],
              ),
            ),
            ),
            SizedBox(width: 2.w,),
            Container(
              height: 16.h,
              width: 45.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.sp),
                border: Border.all(color: Colors.grey.shade400)
              ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bank Offer',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 11.sp)),
                  SizedBox(height: 0.5.h,),
                  Text('Upto ₹1,750.00 discount on select Credit Cards, HDFC…',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 10.sp)),
                  SizedBox(height: 0.5.h,),
                  Text('7 offers >',style: TextStyle(color: Colors.teal,fontWeight: FontWeight.w400,fontSize: 10.sp)),

                ],
              ),
            ),
            ),
            SizedBox(width: 2.w,),
            Container(
              height: 16.h,
              width: 45.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.sp),
                border: Border.all(color: Colors.grey.shade400)
              ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Partner Offer',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 11.sp)),
                  SizedBox(height: 0.5.h,),
                  Text('Get GST invoice and save up to 28% on business purchases.',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 10.sp)),
                  SizedBox(height: 0.5.h,),
                  Text('1 offers >',style: TextStyle(color: Colors.teal,fontWeight: FontWeight.w400,fontSize: 10.sp)),

                ],
              ),
            ),
            ),
            SizedBox(width: 2.w,),

          ],
        ),
      ),
    );
  }


  Widget faciltyBox() {
    return Padding(
      padding: EdgeInsets.only(left: 15.sp,top: 10.sp,right: 15.sp,bottom: 10.sp),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(

          children: [
            Container(
             height: 11.h,
              width: 22.w,
              decoration: BoxDecoration(
                //color: Colors.grey
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 6.h,
                      width: 15.w
                      ,child: Image.asset('assets/detail/truck.jpeg'),
                  ),
                  SizedBox(height: 0.5.h,),
                  Text('Free Delivery',style: TextStyle(color: Colors.teal,fontSize: 9.sp)),
                ],
              ),
            ),
            SizedBox(width: 2.w,),
            Container(
              height: 11.h,
              width: 20.w,
              decoration: BoxDecoration(
                //color: Colors.grey
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5.h,
                    width: 15.w
                    ,child: Image.asset('assets/detail/10.jpg'),
                  ),
                  SizedBox(height: 0.5.h,),
                  Text('10 Days',style: TextStyle(color: Colors.teal,fontSize: 9.sp)),
                  Text('Replacem..',style: TextStyle(color: Colors.teal,fontSize: 9.sp)),
                ],
              ),
            ),
            SizedBox(width: 2.w,),
            Container(
              height: 11.h,
              width: 15.w,
              decoration: BoxDecoration(
                //color: Colors.grey
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5.h,
                    width: 15.w
                    ,child: Image.asset('assets/detail/warn.jpg'),
                  ),
                  SizedBox(height: 0.5.h,),
                  Text('3 Year',style: TextStyle(color: Colors.teal,fontSize: 9.sp)),
                  Text('Warranty',style: TextStyle(color: Colors.teal,fontSize: 9.sp)),
                ],
              ),
            ),
            SizedBox(width: 2.w,),
            Container(
              height: 11.h,
              width: 20.w,
              decoration: BoxDecoration(
                //color: Colors.grey
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5.5.h,
                    width: 15.w
                    ,child: Image.asset('assets/detail/brand.jpg'),
                  ),
                  SizedBox(height: 0.5.h,),
                  Text('Top Brand',style: TextStyle(color: Colors.teal,fontSize: 9.sp)),
                ],
              ),
            ),
            SizedBox(width: 2.w,),
            Container(
              height: 11.h,
              width: 18.w,
              decoration: BoxDecoration(
                //color: Colors.grey
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5.5.h,
                    width: 15.w
                    ,child: Image.asset('assets/detail/ass.jpg'),
                  ),
                  SizedBox(height: 0.5.h,),
                  Text('Assembly',style: TextStyle(color: Colors.teal,fontSize: 9.sp)),
                  Text('available',style: TextStyle(color: Colors.teal,fontSize: 9.sp)),
                ],
              ),
            ),
            SizedBox(width: 2.w,),
            Container(
              height: 13.h,
              width: 19.w,
              decoration: BoxDecoration(
                //color: Colors.grey
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 5.5.h,
                    width: 15.w
                    ,child: Image.asset('assets/detail/lock.jpg'),
                  ),
                  SizedBox(height: 0.5.h,),
                  Text('Secure',style: TextStyle(color: Colors.teal,fontSize: 9.sp)),
                  Text('transaction',style: TextStyle(color: Colors.teal,fontSize: 9.sp)),
                ],
              ),
            ),
            SizedBox(width: 2.w,),


          ],
        ),
      ),
    );
  }

  Widget detailBox() {
    return Padding(
      padding: EdgeInsets.only(left: 15.sp,top: 10.sp,right: 15.sp,bottom: 10.sp),
      child: Container(
        height: 42.h,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('About the Product',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 10.sp)),
            Text('Smartly designed ${h1.name} which is more than just mere tables in the corner. The luxurious golden touch on the metal makes it an attractive statement in your living room, bedroom or study. Round and resilient marble on the top is more like the cherry on the top which imparts that essential wholesome look to the table.',style: GoogleFonts.poppins(color: Colors.grey,fontSize: 8.sp)),

            SizedBox(height: 1.h,),
            Text('About the Quality',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 10.sp)),
            Text('We take utmost care of the quality and style of the product, and make sure that it goes through several quality checks prior to shipment. Therefore, every product is scrutinized end-to-end, which includes the design, material, and packaging. We ensure that it is shipped timely and reaches you in optimum condition. 100% satisfaction guaranteed! Happy shopping with us!',style: GoogleFonts.poppins(color: Colors.grey,fontSize: 8.sp)),

            SizedBox(height: 1.h,),
            Text('Return Policy',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 10.sp)),
            Text('We have very customer friendly return & refund policies, you can find it here',style: GoogleFonts.poppins(color: Colors.grey,fontSize: 8.sp)),

          ],
        ),
      ),
    );
  }

  Widget reviewBox() {
    return Padding(
      padding: EdgeInsets.only(left: 8.sp,right: 15.sp,bottom: 10.sp),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          children: [
            reBox(h1.img!, h1.name!, h1.price!, h1.rating!),
            reBox(h1.img!, h1.name!, h1.price!, h1.rating!),
            reBox(h1.img!, h1.name!, h1.price!, h1.rating!),
          ],
        ),
      ),
    );
  }


  Widget reBox(String img, String name, int price,int rating,)
  {
    return Container(
      margin: EdgeInsets.all(10),
      height: 22.h,
      width: 70.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [ BoxShadow(color: Colors.black12,offset: Offset(0,5),blurRadius: 8,spreadRadius: 3)],
        border: Border.all(color: Colors.grey.shade400)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: 8.h,
                width: 20.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network('$img',fit: BoxFit.cover,)),
              ),
              SizedBox(width: 2.w,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$name',style: GoogleFonts.poppins(color: Colors.black,fontSize: 10.sp,letterSpacing: 1)),
                  Text('\$ $price',style: GoogleFonts.poppins(color: Colors.black,fontSize: 10.sp,letterSpacing: 1,fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,bottom: 5),
            child: Row(
              children: [
                Text('$rating.8',style: GoogleFonts.poppins(color: Colors.black,fontSize: 9.sp,letterSpacing: 1,fontWeight: FontWeight.w500)),
                SizedBox(width: 1.w,),
                Icon(Icons.star,color: Colors.amber,size: 10.sp,),
                Icon(Icons.star,color: Colors.amber,size: 10.sp,),
                Icon(Icons.star,color: Colors.amber,size: 10.sp,),
                Icon(Icons.star,color: Colors.amber,size: 10.sp,),
                Icon(Icons.star,color: Colors.amber,size: 10.sp,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('This was my first buy ever from Wallmantra and its worth every penny.Thank you Wallmantra!',style: GoogleFonts.overpass(color: Colors.grey,fontSize: 8.sp)),
          ),
        ],
      ),
    );
  }
}

