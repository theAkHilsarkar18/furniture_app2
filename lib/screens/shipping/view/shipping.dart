import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shopping_app/screens/shipping/controller/shippingcontroller.dart';
import 'package:furniture_shopping_app/screens/shipping/model/shipingmodel.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/firebase_helper.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

ShippingController shippingController = Get.put(ShippingController());

class _ShippingScreenState extends State<ShippingScreen> {
  List<ShippingModel> addressList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/address');
          },
          backgroundColor: Colors.black,
          child: Icon(Icons.add, color: Colors.white),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          title: Text('Shipping address',
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp)),
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back, color: Colors.black, size: 16.sp)),
        ),
        body: StreamBuilder(
          stream: FirebaseHelper.firebaseHelper.readUserAddress(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (snapshot.hasData) {
              QuerySnapshot? querySnapshot = snapshot.data;
              addressList.clear();
              for (var x in querySnapshot!.docs) {
                Map data = x.data() as Map;
                String docId = x.id;
                ShippingModel s1 = ShippingModel(
                  docId: docId,
                  name: data['name'],
                  address: data['address'],
                  country: data['country'],
                  state: data['state'],
                  city: data['city'],
                  zipcode: data['zipcode'],
                );
                addressList.add(s1);
              }
              return ListView.builder(
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        shippingController.selectAddress(index + 1);
                      },
                    onDoubleTap: () async {
                      await FirebaseHelper.firebaseHelper.deleteUserAddress(addressList[index].docId!);
                    },
                      child: addressBox(
                          index + 1,
                        addressList[index].name!,
                        addressList[index].address!,
                        addressList[index].country!,
                        addressList[index].state!,
                        addressList[index].city!,
                        addressList[index].zipcode!,
                      ),),
                  itemCount: addressList.length);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget addressBox(int index, String name, String address, String country, String state, String city, String code) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      height: 20.h,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25, bottom: 10),
            child: Obx(
              () => Row(
                children: [
                  shippingController.isSelected.value == index
                      ? Text('$index.',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 13.sp))
                      : Text('$index.',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                              color: Colors.grey)),
                  SizedBox(
                    width: 1.w,
                  ),
                  shippingController.isSelected.value == index
                      ? Text('Use as the shipping address',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500, fontSize: 13.sp))
                      : Text('Use as the shipping address',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                              color: Colors.grey)),
                ],
              ),
            ),
          ),
          Obx(
            () => Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 15.sp, right: 15.sp),
              height: 14.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 5),
                      blurRadius: 10,
                      spreadRadius: 1)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  shippingController.isSelected.value == index
                      ? Text('$name',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 13.sp))
                      : Text('$name',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                              color: Colors.grey)),
                  Divider(),
                  Spacer(),
                  Text(
                      '$address, $city, $state, $country - $code',
                      style: GoogleFonts.poppins(
                          fontSize: 10.sp, color: Colors.grey)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
