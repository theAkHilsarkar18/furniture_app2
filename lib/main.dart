import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_shopping_app/screens/addcard/view/addpayment.dart';
import 'package:furniture_shopping_app/screens/bell/view/bellscreen.dart';
import 'package:furniture_shopping_app/screens/cart/view/cartscreen.dart';
import 'package:furniture_shopping_app/screens/checkout/view/checkoutscreen.dart';
import 'package:furniture_shopping_app/screens/detail/view/detailscreen.dart';
import 'package:furniture_shopping_app/screens/favourite/view/favouritescreen.dart';
import 'package:furniture_shopping_app/screens/home/view/homescreen.dart';
import 'package:furniture_shopping_app/screens/insertaddress/view/insertaddress.dart';
import 'package:furniture_shopping_app/screens/intro/view/introscreen.dart';
import 'package:furniture_shopping_app/screens/myorder/view/myorderscreen.dart';
import 'package:furniture_shopping_app/screens/navigation%20bar/view/navigationbarscreen.dart';
import 'package:furniture_shopping_app/screens/operation/view/operationscreen.dart';
import 'package:furniture_shopping_app/screens/payment/view/payment.dart';
import 'package:furniture_shopping_app/screens/profile/view/profilescreen.dart';
import 'package:furniture_shopping_app/screens/review/view/review.dart';
import 'package:furniture_shopping_app/screens/setting/view/setting.dart';
import 'package:furniture_shopping_app/screens/shipping/view/shipping.dart';
import 'package:furniture_shopping_app/screens/signin_signup/view/signin.dart';
import 'package:furniture_shopping_app/screens/signin_signup/view/signup.dart';
import 'package:furniture_shopping_app/screens/splash/view/splashscreen.dart';
import 'package:furniture_shopping_app/screens/success/view/success.dart';
import 'package:furniture_shopping_app/utils/firebase_helper.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseHelper.firebaseHelper.getUserDetail();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.white));
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          textTheme: TextTheme(),
        ),
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(name: '/',page: () => SplashScreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/intro',page: () => Introscreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/signin',page: () => SigninScreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/signup',page: () => SignupScreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/home',page: () => Homescreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/bar',page: () => NavigationbarScreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/detail',page: () => Detailscreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/fav',page: () => FavouriteScreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/cart',page: () => CartScreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/profile',page: () => ProfileScreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/order',page: () => MyOrderScreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/ship',page: () => ShippingScreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/payment',page: () => PaymentScreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/checkout',page: () => CheckoutScreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/review',page: () => ReviewScreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/success',page: () => SuccessScreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/bell',page: () => BellScreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/address',page: () => InsertAddressScreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/addcard',page: () => AddPaymentCardScreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/setting',page: () => SettingScreen(),transition: Transition.cupertinoDialog),
          GetPage(name: '/operation',page: () => OperationScreen(),transition: Transition.cupertinoDialog),
        ],
      ),
    ),
  );
}