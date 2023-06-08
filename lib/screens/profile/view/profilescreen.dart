import 'package:flutter/material.dart';
import 'package:furniture_shopping_app/screens/profile/controller/profilecontroller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());

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
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text('Profile',style: GoogleFonts.overpass(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.w600)),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Obx(
                    () => CircleAvatar(

                      radius: 32.sp,
                      backgroundImage: profileController.img.isEmpty?NetworkImage('https://1fid.com/wp-content/uploads/2022/06/cool-profile-picture-2-1024x1024.jpg'):NetworkImage('${profileController.img.value}'),
                    ),
                  ),
                  SizedBox(width: 4.w,),
                  Obx(
                    () => Container(
                      width: 70.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${profileController.name.value}',overflow: TextOverflow.ellipsis,style: GoogleFonts.overpass(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.w700,letterSpacing: 1)),
                          Text('${profileController.email.value}',style: GoogleFonts.overpass(color: Colors.grey,fontSize: 11.sp,),overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 2.h,),
            Expanded(child: Container(height: 100,child: ListView.builder(itemBuilder: (context, index) => InkWell(
              onTap: () {
                if(index==0)
                  {
                    Get.toNamed('/order');
                  }
                else if(index==1)
                  {
                    Get.toNamed('/ship');
                  }
                else if(index==2)
                  {
                    Get.toNamed('/payment');
                  }
                else if(index==3)
                  {
                    Get.toNamed('/review');
                  }
                else if(index==4)
                  {
                    Get.toNamed('/setting');
                  }
              },
              child: profileMenuBox(
                profileController.profileMenuList[index].title!,
                profileController.profileMenuList[index].description!,
              ),
            ),itemCount: profileController.profileMenuList.length,shrinkWrap: true,))),
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  Container profileMenuBox(String title , String desc)
  {
    return Container(
      padding: EdgeInsets.all(10.sp),
      margin: EdgeInsets.only(left: 20.sp,right: 20.sp,top: 10.sp,bottom: 10.sp),
      height: 11.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          boxShadow: [ BoxShadow(color: Colors.black12,offset: Offset(0,5),blurRadius: 10,spreadRadius: 1)],
          color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${title}',style: GoogleFonts.overpass(color: Colors.black,fontSize: 14.sp,fontWeight: FontWeight.w700,)),
              SizedBox(height: 2,),
              Text('${desc}',style: GoogleFonts.overpass(color: Colors.grey,fontSize: 10.sp,)),
            ],
          ),
          Icon(Icons.navigate_next,color: Colors.black,size: 20.sp,),
        ],
      ),
    );
  }



}
