import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:furniture_shopping_app/screens/addcard/controller/addpaymenrcontrolerr.dart';
import 'package:furniture_shopping_app/utils/firebase_helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AddPaymentCardScreen extends StatefulWidget {
  const AddPaymentCardScreen({super.key});

  @override
  State<AddPaymentCardScreen> createState() => _AddPaymentCardScreenState();
}

class _AddPaymentCardScreenState extends State<AddPaymentCardScreen> {


  AddPaymentController addPaymentController = Get.put(AddPaymentController());
  TextEditingController txtName = TextEditingController();
  TextEditingController txtCvv = TextEditingController();
  TextEditingController txtDate = TextEditingController();
  TextEditingController txtBank = TextEditingController();
  TextEditingController txtNumber = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
          title: Text('Add payment method',style: GoogleFonts.overpass(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 15.sp)),
        ),
        backgroundColor: Colors.white,

        body:  SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 2.h,),
              Obx(
                () => InkWell(
                  onTap: () {
                    addPaymentController.changeCardSide();
                  },
                  child: CreditCard(
                      cardNumber: "${addPaymentController.number}",
                      cardExpiry: "${addPaymentController.expDate}",
                      cardHolderName: "${addPaymentController.name}",
                      cvv: "${addPaymentController.cvv}",
                      bankName: "${addPaymentController.bank}",
                      //cardType: CardType.mastercard,
                      showBackSide: addPaymentController.cardSide.value,
                      frontBackground: CardBackgrounds.black,
                      backBackground: CardBackgrounds.black,
                      backTextColor: Colors.white,
                      showShadow: true,
                      textExpDate: 'Exp. Date',
                      textName: 'Name',
                      textExpiry: 'MM/YY'
                  ),
                ),
              ),
              SizedBox(height: 4.h,),
              Padding(
                padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                child: TextFormField(
                  onChanged: (value) {
                    addPaymentController.name.value = value;
                  },
                  maxLength: 15,
                  controller: txtName,
                  keyboardType: TextInputType.name,
                  cursorColor: Colors.black,
                  style: GoogleFonts.poppins(letterSpacing: 1,color: Colors.black),
                  decoration: InputDecoration(
                    counterText: '',
                    label: Text('CardHolder Name',style: GoogleFonts.overpass(color: Colors.grey,fontSize: 15,letterSpacing: 1)),
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
                padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                child: TextFormField(
                  onChanged: (value) {
                    addPaymentController.number.value = value;
                  },
                  controller: txtNumber,
                  keyboardType: TextInputType.number,
                  maxLength: 20,
                  cursorColor: Colors.black,
                  style: GoogleFonts.poppins(letterSpacing: 1,color: Colors.black),
                  decoration: InputDecoration(
                    counterText: '',
                    label: Text('Card Number',style: GoogleFonts.overpass(color: Colors.grey,fontSize: 15,letterSpacing: 1)),
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
                padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                child: TextFormField(
                  controller: txtBank,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    addPaymentController.bank.value = value;
                  },
                  maxLength: 10,
                  cursorColor: Colors.black,
                  style: GoogleFonts.poppins(letterSpacing: 1,color: Colors.black),
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: 'ex. HDFC',
                    hintStyle: GoogleFonts.poppins(color: Colors.grey,fontSize: 15),
                    suffix: Text('Bank',style: GoogleFonts.poppins(fontSize: 15,color: Colors.black)),
                    label: Text('Bank Name',style: GoogleFonts.overpass(color: Colors.grey,fontSize: 15,letterSpacing: 1)),
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
                padding:  EdgeInsets.only(top: 10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.sp),
                      child: Container(
                        width: 40.w,
                        child: TextFormField(
                          onChanged: (value) {
                            addPaymentController.cvv.value = value;
                          },
                          controller: txtCvv,
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          cursorColor: Colors.black,
                          style: GoogleFonts.poppins(letterSpacing: 1,color: Colors.black),
                          decoration: InputDecoration(
                            counterText: '',
                            label: Text('CVV',style: GoogleFonts.overpass(color: Colors.grey,fontSize: 15,letterSpacing: 1)),
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
                    ),
                    Padding(
                      padding:  EdgeInsets.only(right: 15.sp),
                      child: Container(
                        width: 40.w,
                        child: TextFormField(
                          onChanged: (value) {
                            addPaymentController.expDate.value = value;
                          },
                          controller: txtDate,
                          maxLength: 10,
                          keyboardType: TextInputType.datetime,
                          cursorColor: Colors.black,
                          style: GoogleFonts.poppins(letterSpacing: 1,color: Colors.black),
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: '10/28',
                            hintStyle: GoogleFonts.poppins(color: Colors.grey,fontSize: 15),
                            label: Text('Expiration Date',style: GoogleFonts.overpass(color: Colors.grey,fontSize: 14,letterSpacing: 1)),
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
                    ),
                  ],
                ),
              ),

              GestureDetector(onTap: () async {

                Map<String, dynamic> m1 = {

                  'name' : txtName.text,
                  'number' : txtNumber.text,
                  'bank' : txtBank.text,
                  'date' : txtDate.text,
                  'cvv' : txtCvv.text,


                };
                await FirebaseHelper.firebaseHelper.addUserCardDetail(m1);
                Get.back();
              },child: Align(heightFactor: 2,child: saveCardBox()))
            ],
          ),
        ),
      ),
    );
  }


  Widget paymentBox()
  {
    return Obx(
      () =>  Column(
        children: [
          Container(
            height: 25.h,
            width: 87.w,
            margin: EdgeInsets.only(left: 5.sp,right: 5.sp,top: 10.sp),
            decoration: BoxDecoration(
              //color: Colors.tealAccent,
              boxShadow: [ BoxShadow(color: Colors.black12,offset: Offset(0,5),blurRadius: 10,spreadRadius: 1)],

            ),
            child: Stack(
              children: [
                Image.asset('assets/payment/card1.png',fit: BoxFit.cover,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(height: 2.h,width:20.w,child: Image.asset('assets/payment/visa.png')),
                      Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${addPaymentController.bank.value}',style: GoogleFonts.poppins(fontWeight: FontWeight.w700,color: Colors.white,fontSize: 15.sp)),
                          Text('bank',style: GoogleFonts.poppins(color: Colors.white,fontSize: 15.sp)),
                        ],
                      ),
                      SizedBox(width: 2.w,),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('PLATINUM',style: GoogleFonts.robotoMono(color: Colors.grey.shade50,fontSize: 14.sp,wordSpacing: 10)),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, 110),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${addPaymentController.number.value}',style: GoogleFonts.robotoMono(color: Colors.grey.shade100,fontSize: 15.sp,wordSpacing: 5)),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, 150),
                  child: Row(
                    children: [
                      SizedBox(width: 5.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('NAME',style: GoogleFonts.overpass(color: Colors.grey.shade100,fontSize: 5.sp)),
                          Text('${addPaymentController.name.value}',style: GoogleFonts.robotoMono(color: Colors.grey.shade100,fontSize: 11.sp)),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text('VALID FROM',style: GoogleFonts.overpass(color: Colors.grey.shade100,fontSize: 5.sp)),
                          Text('06/17',style: GoogleFonts.robotoMono(color: Colors.grey.shade100,fontSize: 11.sp,wordSpacing: 10)),
                        ],
                      ),
                      SizedBox(width: 2.w,),
                      Column(
                        children: [
                          Text('VALID THRU',style: GoogleFonts.overpass(color: Colors.grey.shade100,fontSize: 5.sp)),
                          Text('${addPaymentController.expDate.value}',style: GoogleFonts.robotoMono(color: Colors.grey.shade100,fontSize: 11.sp,wordSpacing: 10)),
                        ],
                      ),
                      SizedBox(width: 5.w,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget saveCardBox()
  {
    return Container(
      margin: EdgeInsets.only(left: 15.sp,right: 15.sp,top: 40.sp),
      height: 6.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text('Add new card',style: GoogleFonts.overpass(color: Colors.white,letterSpacing: 1,fontSize: 13.sp)),
    );
  }

}
