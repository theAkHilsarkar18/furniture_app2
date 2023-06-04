import 'package:furniture_shopping_app/screens/intro/view/introscreen.dart';
import 'package:furniture_shopping_app/utils/shr_helper.dart';
import 'package:get/get.dart';

class IntroController extends GetxController
{
  String introDesc = 'The best simple place where you discover most wonderful furnitures and make your home beautiful';
  RxBool introWatched = false.obs;

  void checkIntro()
  async {
    Map m1 = await ShrHelper.shrHelper.getForIntro();
    introWatched.value = m1['intro'];
    print('${introWatched}======================');
  }
}