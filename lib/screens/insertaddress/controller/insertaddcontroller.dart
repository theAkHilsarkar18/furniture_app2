import 'package:get/get.dart';

class InserAddressController extends GetxController
{
  RxString countryValue = ''.obs;
  RxString stateValue = ''.obs;
  RxString cityValue = ''.obs;

  void selectCity(String value)
  {
    cityValue.value = value;
  }

  void selectState(String value)
  {
    stateValue.value = value;
  }

  void selectCountry(String value)
  {
    countryValue.value = value;
  }

}