import 'package:flutter/material.dart';
import 'package:furniture_shopping_app/screens/intro/controller/introcontroller.dart';
import 'package:furniture_shopping_app/utils/shr_helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Introscreen extends StatefulWidget {
  const Introscreen({Key? key}) : super(key: key);

  @override
  State<Introscreen> createState() => _IntroscreenState();
}
IntroController introController = Get.put(IntroController());
class _IntroscreenState extends State<Introscreen> {

  IntroController introController =   Get.put(IntroController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/intro/intro.png',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(top: 40, right: 10,left: 10),
                  child: Text(
                    'MAKE YOUR HOME BEAUTIFUL',
                    style: GoogleFonts.actor(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30,right: 30),
                  child: Text('${introController.introDesc}',style: GoogleFonts.poppins(color: Colors.grey,fontSize: 12,letterSpacing: 1)),
                ),
                Spacer(),
                InkWell(onTap: () {
                  ShrHelper.shrHelper.checkForIntro(true);
                  Get.offAndToNamed('/signin');
                },child: getStartedBox()),

                Image.asset('assets/intro/Indicator.png'),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget getStartedBox()
  {
    return Container(
      margin: EdgeInsets.only(left: 15,right: 15,bottom: 10),
      height: 7.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text('Get Started',style: GoogleFonts.overpass(color: Colors.white,letterSpacing: 1,fontSize: 13.sp)),
    );
  }

}
