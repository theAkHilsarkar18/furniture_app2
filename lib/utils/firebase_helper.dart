import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_shopping_app/screens/bell/view/bellscreen.dart';
import 'package:furniture_shopping_app/screens/operation/controller/opcontroller.dart';
import 'package:furniture_shopping_app/screens/profile/controller/profilecontroller.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper
{
  /// Singleton firebase object (Global)
  static FirebaseHelper firebaseHelper = FirebaseHelper._();
  FirebaseHelper._();

  /// Firebase auth object (Global)
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// signUp method
  Future<String> signUp({required email , required password, required name})
  async {
    return await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      return 'Success';
    },).catchError((e){
      return '$e';
    });
  }

  /// signIn method
  Future<String> signIn({required email, required password})
  async {
    return await firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((value) {
      return 'Success';
    },).catchError((e){
      return '$e';
    });
  }

  /// check user is login or not
  bool checkUser()
  {
    User? user = firebaseAuth.currentUser;
    return user != null;
  }

  /// google sign in method
  Future<String> googleSignIn()
  async {
    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
    // create a new credential
    var credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken
    );
    return await firebaseAuth.signInWithCredential(credential).then((value) {
      return 'Success';
    },).catchError((e){
      return '$e';
    });
  }

  /// sign-out / logout method
  ProfileController profileController = Get.put(ProfileController());
  Future<void> signOut()
  async {
    await firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    profileController.name.value = 'add your name';
    profileController.email.value = 'add your email';
    profileController.img.value = 'https://1fid.com/wp-content/uploads/2022/06/cool-profile-picture-2-1024x1024.jpg';
  }

  /// get user detail
  String? userId;
  Future<Map> getUserDetail()
  async {

    User? user  = await firebaseAuth.currentUser;
   userId = user!.uid;
    // homeController.userId.value = user!.uid;
    print('${userId}------------userid--------');
    String? email = user.email;
    String? img = user.photoURL;
    String? name = user.displayName;
    Map m1 = {'email':email,'img':img,'name':name};
    return m1;
  }

  /// Firestore CRUD Operations///

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


  /// read data from firestore for main product list
  Stream<QuerySnapshot<Map<String, dynamic>>> readProductData()
  {
    return firebaseFirestore.collection('ProductList').snapshots();
  }

  // TODO add data in add to cart

  Future<void> addToCartProduct(Map<String,dynamic> m1)
  async {
    await firebaseFirestore.collection('AddToCart').doc(userId).collection('Cart').add(m1);
  }

// TODO read data from add to cart

  Stream<QuerySnapshot<Map<String, dynamic>>> readDataFromAddToCart()
  {
    return firebaseFirestore.collection('AddToCart').doc(userId).collection('Cart').snapshots();
  }

  // TODO delete data from cart

  Future<void> deleteCartData(String docId)
  async {
    await firebaseFirestore.collection('AddToCart').doc(userId).collection('Cart').doc(docId).delete();
  }

  // TODO Checkout add data

  Future<void> checkOutProduct(Map<String, dynamic> m1)
  async {
    await firebaseFirestore.collection('CheckOut').doc(userId).collection('CheckOutProducts').add(m1);
  }


}