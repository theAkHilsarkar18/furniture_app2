import 'package:get/get.dart';

class PaymentController extends GetxController
{
  RxInt isSelected = 1.obs;
  void selectCardIndex(int index)
  {
    isSelected.value = index;
  }

  RxBool cardSide = false.obs;

  void changeCardSide()
  {
    cardSide.value = !cardSide.value;
  }

}