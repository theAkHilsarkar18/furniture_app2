import 'package:flutter/material.dart';
import 'package:furniture_shopping_app/utils/firebase_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(onTap: () {
            Get.back();
          },child: Icon(Icons.arrow_back,size: 20.sp,color: Colors.black,)),
          centerTitle: true,
          title: Text('Setting',style: GoogleFonts.overpass(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 15.sp)),
        ),
        body: Column(
          children: [
            settingBox('Personal Information',),
            settingBox('Password',),
            settingBox('Notification',),
            settingBox('Contact Us',),
            settingBox('FAQ',),
            settingBox('Privacy & Terms',),
            InkWell(onTap: () async {
              await FirebaseHelper.firebaseHelper.signOut();
              Get.offAndToNamed('/signin');
            },child: settingBox('LogOut',)),
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  Container settingBox(String title)
  {
    return Container(
      padding: EdgeInsets.all(10.sp),
      margin: EdgeInsets.only(left: 10.sp,right: 10.sp,top: 10.sp,bottom: 10.sp),
      height: 9.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          boxShadow: [ BoxShadow(color: Colors.black12,offset: Offset(0,5),blurRadius: 10,spreadRadius: 1)],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${title}',style: GoogleFonts.overpass(color: Colors.black,fontSize: 13.sp,fontWeight: FontWeight.w700,)),
          Icon(Icons.navigate_next,color: Colors.black,size: 20.sp,),
        ],
      ),
    );
  }


}
