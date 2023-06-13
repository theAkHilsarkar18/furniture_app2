import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shopping_app/screens/checkout/controller/checkoutcontroller.dart';
import 'package:furniture_shopping_app/screens/payment/controller/paymentcontroller.dart';
import 'package:furniture_shopping_app/screens/payment/model/paymentmodel.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/firebase_helper.dart';
import '../../shipping/model/shipingmodel.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

PaymentController paymentController = Get.put(PaymentController());
CheckoutController checkoutController = Get.put(CheckoutController());

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  List<PaymentModel> cardsList = [];

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            paymentController.totalCards.value = cardsList.length;
            Get.toNamed('/addcard');
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('Payment method',
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
          stream: FirebaseHelper.firebaseHelper.readPaymentDetail(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (snapshot.hasData) {
              QuerySnapshot? querySnapshot = snapshot.data;
              cardsList.clear();

              for (var x in querySnapshot!.docs) {
                Map data = x.data() as Map;
                String docId = x.id;
                PaymentModel p1 = PaymentModel(
                  docId: docId,
                  name: data['name'],
                  number: data['number'],
                  cvv: data['cvv'],
                  bank: data['bank'],
                  date: data['date'],
                );
                cardsList.add(p1);
              }
              return ListView.builder(
                itemBuilder: (context, index) => InkWell(
                    splashColor: Colors.white12,
                  onDoubleTap: () async {
                    await FirebaseHelper.firebaseHelper.deleteUserCard(cardsList[index].docId!);
                  },
                    onTap: () {
                      checkoutController.cardNumber.value = cardsList[index].number!;
                      checkoutController.bankName.value = cardsList[index].bank!;
                      print('${checkoutController.cardNumber}=============');
                      paymentController.selectCardIndex(index + 1);

                    },
                    child: paymentBox(
                      index + 1,
                      cardsList[index].name!,
                      cardsList[index].bank!,
                      cardsList[index].date!,
                      cardsList[index].cvv!,
                      cardsList[index].number!,
                    ),),
                itemCount: cardsList.length,
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget paymentBox(int index ,String name, String bankname, String date, String cvv, String number) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          paymentController.isSelected.value == index
              ? Padding(
                  padding: EdgeInsets.only(left: 6.w, top: 3.h, bottom: 2.h),
                  child: Text('$index. Primary card',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 15.sp)),
                )
              : Padding(
                  padding: EdgeInsets.only(left: 5.w, top: 1.h, bottom: 1.h),
                  child: Text('',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: Colors.grey)),
                ),
          paymentController.isSelected.value == index
              ? CreditCard(
                  cardNumber: "$number",
                  cardExpiry: "$date",
                  cardHolderName: "$name",
                  cvv: "$cvv",
                  bankName: "$bankname",
                  //cardType: CardType.mastercard,
                  showBackSide: false,
                  frontBackground: CardBackgrounds.black,
                  backBackground: CardBackgrounds.black,
                  backTextColor: Colors.white,
                  showShadow: true,
                  textExpDate: 'Exp. Date',
                  textName: 'Name',
                  textExpiry: 'MM/YY')
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CreditCard(
                      cardNumber: "$number",
                      cardExpiry: "$date",
                      cardHolderName: "$name",
                      cvv: "$cvv",
                      bankName: "$bankname",
                      //cardType: CardType.mastercard,
                      showBackSide: false,
                      frontBackground: CardBackgrounds.black,
                      backBackground: CardBackgrounds.black,
                      backTextColor: Colors.white,
                      showShadow: true,
                      textExpDate: 'Exp. Date',
                      textName: 'Name',
                      textExpiry: 'MM/YY'),
                )
        ],
      ),
    );
  }

// Widget paymentBox(int index)
// {
//   return Column(
//     children: [
//       Padding(
//         padding:  EdgeInsets.only(left: 30,top:30 ),
//         child: Obx(
//               () => Row(
//             children: [
//               paymentController.isSelected.value==index?Text('$index.',style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 13.sp)):Text('$index.',style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 12.sp,color: Colors.grey)),
//               SizedBox(width: 1.w,),
//               paymentController.isSelected.value==index?Text('Use as default payment method',style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 13.sp)):Text('Use as default payment method',style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 12.sp,color: Colors.grey)),
//             ],
//           ),
//         ),
//       ),
//       Obx(
//         () =>  Stack(
//           children: [
//             Container(
//               height: 25.h,
//               width: 87.w,
//               margin: EdgeInsets.all(10.sp),
//               decoration: BoxDecoration(
//                 //color: Colors.white,
//                // boxShadow: [ BoxShadow(color: Colors.black12,offset: Offset(0,5),blurRadius: 10,spreadRadius: 1)],
//
//               ),
//               child: Stack(
//                 children: [
//                   Image.asset('assets/payment/card1.png',fit: BoxFit.cover,),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(height: 2.h,width:20.w,child: Image.asset('assets/payment/visa.png')),
//                         Spacer(),
//                         Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text('Axis',style: GoogleFonts.poppins(fontWeight: FontWeight.w700,color: Colors.white,fontSize: 15.sp)),
//                             Text('bank',style: GoogleFonts.poppins(color: Colors.white,fontSize: 15.sp)),
//                           ],
//                         ),
//                         SizedBox(width: 2.w,),
//                       ],
//                     ),
//                   ),
//                   Transform.translate(
//                     offset: Offset(0, 70),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('PLATINUM',style: GoogleFonts.robotoMono(color: Colors.grey.shade50,fontSize: 14.sp,wordSpacing: 10)),
//                       ],
//                     ),
//                   ),
//                   Transform.translate(
//                     offset: Offset(0, 110),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('5520 1233 5623 9800',style: GoogleFonts.robotoMono(color: Colors.grey.shade100,fontSize: 15.sp,wordSpacing: 5)),
//                       ],
//                     ),
//                   ),
//                   Transform.translate(
//                     offset: Offset(0, 150),
//                     child: Row(
//                       children: [
//                         SizedBox(width: 5.w,),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('NAME',style: GoogleFonts.overpass(color: Colors.grey.shade100,fontSize: 5.sp)),
//                             Text('TheAkhilSarkar',style: GoogleFonts.robotoMono(color: Colors.grey.shade100,fontSize: 11.sp)),
//                           ],
//                         ),
//                         Spacer(),
//                         Column(
//                           children: [
//                             Text('VALID FROM',style: GoogleFonts.overpass(color: Colors.grey.shade100,fontSize: 5.sp)),
//                             Text('10/17',style: GoogleFonts.robotoMono(color: Colors.grey.shade100,fontSize: 11.sp,wordSpacing: 10)),
//                           ],
//                         ),
//                         SizedBox(width: 2.w,),
//                         Column(
//                           children: [
//                             Text('VALID THRU',style: GoogleFonts.overpass(color: Colors.grey.shade100,fontSize: 5.sp)),
//                             Text('10/27',style: GoogleFonts.robotoMono(color: Colors.grey.shade100,fontSize: 11.sp,wordSpacing: 10)),
//                           ],
//                         ),
//                         SizedBox(width: 5.w,),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             paymentController.isSelected.value!=index? Container(
//               height: 25.h,
//               width: 87.w,
//               margin: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   color: Colors.white54,
//                 borderRadius: BorderRadius.circular(15)
//               ),
//             ):
//             Container(
//               height: 25.h,
//               width: 87.w,
//               margin: EdgeInsets.all(10),
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }
}
