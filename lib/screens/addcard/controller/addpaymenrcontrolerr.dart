import 'package:get/get.dart';

class AddPaymentController extends GetxController
{
  RxString name = ''.obs;
  RxString number = ''.obs;
  RxString expDate = ''.obs;
  RxString bank = ''.obs;
  RxString cvv = ''.obs;

  RxBool cardSide = false.obs;

  void changeCardSide()
  {
    cardSide.value = !cardSide.value;
  }
}