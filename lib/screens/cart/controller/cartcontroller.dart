import 'package:get/get.dart';

class CartController extends GetxController
{
  RxInt cartQuantity = 1.obs;
  RxInt productIndex = 0.obs;
  RxInt total = 0.obs;
  List<int> priceList = [];

  void incrementQuantity()
  {
    cartQuantity.value++;
  }

  void decrementQuantity()
  {
    if(cartQuantity.value > 1)
    {
      cartQuantity.value--;
    }
  }
}