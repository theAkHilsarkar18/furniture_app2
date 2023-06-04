import 'package:shared_preferences/shared_preferences.dart';

class ShrHelper
{
  static ShrHelper shrHelper = ShrHelper._();
  ShrHelper._();

  Future<void> checkForIntro(bool intro)
  async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('intro', intro);
  }

  Future<Map> getForIntro()
  async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? intro = await sharedPreferences.getBool('intro');
    Map m1 = {'intro':intro};
    return m1;
  }
}