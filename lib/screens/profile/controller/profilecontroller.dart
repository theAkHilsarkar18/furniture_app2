import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_shopping_app/screens/profile/model/profilemodel.dart';
import 'package:furniture_shopping_app/screens/shipping/controller/shippingcontroller.dart';
import 'package:furniture_shopping_app/utils/firebase_helper.dart';
import 'package:get/get.dart';
ShippingController shippingController = Get.put(ShippingController());
class ProfileController extends GetxController
{



  List<ProfileModal> profileMenuList = [
    ProfileModal(title: 'My orders',description: 'Already have 6 orders'),
    ProfileModal(title: 'Shipping address',description: '${shippingController.totalAddress.value} addresses'),
    ProfileModal(title: 'Payment method',description: 'You have 2 cards'),
    ProfileModal(title: 'My reviews',description: 'Reviews for 5 item'),
    ProfileModal(title: 'Setting',description: 'Notification,Password,FAQ,Contact'),
  ];

  RxString name = 'add your name'.obs;
  RxString email = 'add your email'.obs;
  RxString img = 'https://1fid.com/wp-content/uploads/2022/06/cool-profile-picture-2-1024x1024.jpg'.obs;



  Future<void> getUserDetail()
  async {
    Map m1 = await FirebaseHelper.firebaseHelper.getUserDetail();


    // QuerySnapshot snapshot =  await FirebaseHelper.firebaseHelper.readLoginDetail();
    // Map? user = snapshot.docs as Map;
    // String userName = user['name'];

    name.value = m1['name']==null ? 'default name' : m1['name'];
    email.value = m1['email'];
    img.value = m1['img']==null ? 'https://1fid.com/wp-content/uploads/2022/06/cool-profile-picture-2-1024x1024.jpg' : m1['img'];
    print('$name ============');
    print('$img ==================');
  }
}
