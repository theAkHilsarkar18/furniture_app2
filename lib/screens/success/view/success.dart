import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text('Success !',style: GoogleFonts.overpass(fontSize: 25.sp,fontWeight: FontWeight.w700,color: Colors.black)),
              SizedBox(height: 4.h,),
              Image.asset('assets/payment/done.png'),
              SizedBox(height: 2.h,),
              Text('Your product will be delivered soon',style: GoogleFonts.overpass(fontSize: 12.sp,color: Colors.grey)),
              Text('Thank you for choosing our app !',style: GoogleFonts.overpass(fontSize: 12.sp,color: Colors.grey)),
              Spacer(),
              InkWell(onTap: () {
                Get.toNamed('/order');
              },child: trackBox()),
              SizedBox(height: 1.h,),
              InkWell(onTap: () {
                Get.offAndToNamed('/bar');
              },child: homeBox()),
            ],
          ),
        ),
      ),
    );
  }

  Widget trackBox()
  {
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
      height: 6.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text('Track your orders',style: GoogleFonts.overpass(color: Colors.white,letterSpacing: 1,fontSize: 13.sp)),
    );
  }

  Widget homeBox()
  {
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
      height: 6.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text('Back to home',style: GoogleFonts.overpass(color: Colors.white,letterSpacing: 1,fontSize: 13.sp)),
    );
  }

}
