import 'package:flutter/material.dart';
import 'package:furniture_shopping_app/screens/insertaddress/controller/insertaddcontroller.dart';
import 'package:furniture_shopping_app/utils/firebase_helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class InsertAddressScreen extends StatefulWidget {
  const InsertAddressScreen({super.key});

  @override
  State<InsertAddressScreen> createState() => _InsertAddressScreenState();
}

class _InsertAddressScreenState extends State<InsertAddressScreen> {

  TextEditingController txtName = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtZipcode = TextEditingController();
  TextEditingController txtCountry = TextEditingController();
  TextEditingController txtState = TextEditingController();
  TextEditingController txtCity = TextEditingController();

  InserAddressController inserAddressController = Get.put(InserAddressController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          leading: InkWell(onTap: () {
            Get.back();
          },child: Icon(Icons.arrow_back,size: 20.sp,color: Colors.black,)),
          centerTitle: true,
          title: Text('Add shipping address',style: GoogleFonts.overpass(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 15.sp)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: txtName,
                  keyboardType: TextInputType.name,
                  cursorColor: Colors.black,
                  style: GoogleFonts.poppins(letterSpacing: 1,color: Colors.black),
                  decoration: InputDecoration(
                    label: Text('Full name',style: GoogleFonts.overpass(color: Colors.grey,fontSize: 15,letterSpacing: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey,width: 1.5)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey,width: 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: txtAddress,
                  maxLines: 2,
                  keyboardType: TextInputType.streetAddress,
                  cursorColor: Colors.black,
                  style: GoogleFonts.poppins(letterSpacing: 1,color: Colors.black),
                  decoration: InputDecoration(
                    label: Text('Address',style: GoogleFonts.overpass(color: Colors.grey,fontSize: 15,letterSpacing: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey,width: 1.5)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey,width: 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: txtCountry,
                  keyboardType: TextInputType.streetAddress,
                  cursorColor: Colors.black,
                  style: GoogleFonts.poppins(letterSpacing: 1,color: Colors.black),
                  decoration: InputDecoration(
                    label: Text('Country',style: GoogleFonts.overpass(color: Colors.grey,fontSize: 15,letterSpacing: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey,width: 1.5)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey,width: 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: txtState,
                  keyboardType: TextInputType.streetAddress,
                  cursorColor: Colors.black,
                  style: GoogleFonts.overpass(letterSpacing: 1,color: Colors.black),
                  decoration: InputDecoration(
                    label: Text('State',style: GoogleFonts.poppins(color: Colors.grey,fontSize: 15,letterSpacing: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey,width: 1.5)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey,width: 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: txtCity,
                  keyboardType: TextInputType.streetAddress,
                  cursorColor: Colors.black,
                  style: GoogleFonts.overpass(letterSpacing: 1,color: Colors.black),
                  decoration: InputDecoration(
                    label: Text('City',style: GoogleFonts.poppins(color: Colors.grey,fontSize: 15,letterSpacing: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey,width: 1.5)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey,width: 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: txtZipcode,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  cursorColor: Colors.black,
                  style: GoogleFonts.overpass(letterSpacing: 1,color: Colors.black),
                  decoration: InputDecoration(
                    counterText: '',
                    label: Text('Zipcode (Postal Code)',style: GoogleFonts.poppins(color: Colors.grey,fontSize: 15,letterSpacing: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey,width: 1.5)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey,width: 1),
                    ),
                  ),
                ),
              ),

              GestureDetector(onTap: () async {
                Map<String, dynamic> m1 = {
                  'name' : txtName.text,
                  'address' : txtAddress.text,
                  'country' : txtCountry.text,
                  'state' : txtState.text,
                  'city' : txtCity.text,
                  'zipcode' : txtZipcode.text,
                };
                await FirebaseHelper.firebaseHelper.addUserAddress(m1);
                Get.back();
              },child: Align(heightFactor: 5,child: saveAddressBox())),
            ],
          ),
        ),

      ),
    );
  }


  Widget saveAddressBox()
  {
    return Container(
      margin: EdgeInsets.only(left: 10.sp,right: 10.sp,top: 10.sp),
      height: 6.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text('Save address',style: GoogleFonts.overpass(color: Colors.white,letterSpacing: 1,fontSize: 13.sp)),
    );
  }

}
