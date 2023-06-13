import 'package:get/get.dart';

class ShippingController extends GetxController
{


  RxInt totalAddress = 0.obs;
  RxInt isSelected = 1.obs;
  void selectAddress(int index)
  {
    isSelected.value = index;
  }


}