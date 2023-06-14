import 'dart:async';

import 'package:flutter/material.dart';
import 'package:furniture_shopping_app/screens/intro/controller/introcontroller.dart';
import 'package:furniture_shopping_app/utils/firebase_helper.dart';
import 'package:furniture_shopping_app/utils/shr_helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  IntroController introController = Get.put(IntroController());
  bool isLogin = false;
  bool introWatched = false;
  @override
  initState()  {
    // TODO: implement initState
    super.initState();
    isLogin = FirebaseHelper.firebaseHelper.checkUser();
    introController.checkIntro();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4), () {
      Get.offAndToNamed(isLogin ? '/bar' : introController.introWatched.value?'/signin':'/intro');
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              height: 32.h,
              width: 100.w,
              child: Image.asset('assets/logo/splash.png'),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text('Lovely',
            //         style: GoogleFonts.kalam(
            //             color: Color(0xffff5256),
            //             fontSize: 25.sp,
            //             fontWeight: FontWeight.w700)),
            //     Text('Rooms',
            //         style: GoogleFonts.pacifico(
            //             color: Colors.blue,
            //             fontSize: 20.sp,
            //             fontWeight: FontWeight.w700)),
            //   ],
            // ),
            Spacer(),
            Text('by TheAkhilSarkar',
                style: GoogleFonts.poppins(
                    color: Colors.black54, fontSize: 13.sp)),
            SizedBox(
              height: 1.h,
            ),
          ],
        ),
      ),
    );
  }
}
