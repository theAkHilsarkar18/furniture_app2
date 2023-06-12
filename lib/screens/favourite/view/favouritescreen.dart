import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shopping_app/screens/home/controller/homecontroller.dart';
import 'package:furniture_shopping_app/screens/navigation%20bar/controller/navigationController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/firebase_helper.dart';
import '../../home/model/homemodel.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

HomeController homeController = Get.put(HomeController());
NavigationController navigationController = Get.put(NavigationController());
class _FavouriteScreenState extends State<FavouriteScreen> {



  @override

  List<HomeModel> favouriteList = [];

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text('Favourites',style: GoogleFonts.overpass(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.w500)),
        ),
        body: StreamBuilder(
          stream: FirebaseHelper.firebaseHelper.readFavouriteProductList(),
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
                    stock: data['stock'],
                    rating: data['rating'],
                    categoryId: data['categoryId'],
                    userId: '${homeController.userId.value}');
                favouriteList.add(h1);
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
                      index
                    ),itemCount: homeController.productList.length,),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {

                        for(int i=0; i<favouriteList.length; i++)
                        {
                          Map<String, dynamic> m1 = {
                            'name' : favouriteList[i].name,
                            'price' : favouriteList[i].price,
                            'quantity': 1,
                            'img' : favouriteList[i].img,
                            'stock' : favouriteList[i].stock,
                            'rating' : favouriteList[i].rating,
                            'description' : favouriteList[i].description,
                            'categoryId' : favouriteList[i].categoryId,
                          };
                          FirebaseHelper.firebaseHelper.addToCartProduct(m1);
                          FirebaseHelper.firebaseHelper.deleteFavouriteProducts(favouriteList[i].productId!);
                        }



                      },
                      child: Container(
                        margin: EdgeInsets.all(20),
                        height: 6.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text('All add to my cart',style: GoogleFonts.overpass(color: Colors.white,letterSpacing: 1,fontSize: 13.sp)),
                      ),
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

  Widget favouriteBox(String img, String pname, int price, int i)
  {
    return Container(
      margin: EdgeInsets.all(10),
      height: 17.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white
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
                    style: GoogleFonts.poppins(color: Colors.grey,fontSize: 12.sp),
                  ),
                  SizedBox(height: 1.h,),
                  Text(
                    '\$ ${price}',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(color: Colors.black,fontSize: 14.sp,fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  SizedBox(height: 1.h,),
                  InkWell(onTap: () async {
                    await FirebaseHelper.firebaseHelper.deleteFavouriteProducts(favouriteList[i].productId!);
                  },child: Icon(Icons.close)),
                  SizedBox(height: 6.h,),
                  InkWell(onTap: () async {
                    Map<String, dynamic> m1 = {
                      'name' : favouriteList[i].name,
                      'price' : favouriteList[i].price,
                      'quantity': 1,
                      'img' : favouriteList[i].img,
                      'stock' : favouriteList[i].stock,
                      'rating' : favouriteList[i].rating,
                      'description' : favouriteList[i].description,
                      'categoryId' : favouriteList[i].categoryId,
                    };
                    await FirebaseHelper.firebaseHelper.addToCartProduct(m1);
                    await FirebaseHelper.firebaseHelper.deleteFavouriteProducts(favouriteList[i].productId!);
                  },child: Icon(Icons.shopping_bag,color: Colors.black,)),
                  SizedBox(height: 1.h,),
                ],
              ),
              SizedBox(width: 3.w,),
            ],
          ),
          SizedBox(height: 1.h,),
          Divider(),
        ],
      ),
    );
  }


}
