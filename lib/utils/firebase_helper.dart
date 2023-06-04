import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Future<Map> getUserDetail()
  async {
    User? user  = await firebaseAuth.currentUser;
    String? email = user!.email;
    String? img = user.photoURL;
    String? name = user.displayName;
    Map m1 = {'email':email,'img':img,'name':name};
    return m1;
  }

  /// Firestore CRUD Operations///

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


  /// add data into firestore
  void addFurnitureData()
  {
    firebaseFirestore.collection('LovelyRoom').doc('Data').collection('ProductList').add({'name': 'Akhil'});
    firebaseFirestore.collection('LovelyRoom').doc('Data').collection('FavouriteList').add({'name': 'Hetal'});
    firebaseFirestore.collection('LovelyRoom').doc('Data').collection('CartList').add({'name': 'Cart'});
    firebaseFirestore.collection('LovelyRoom').doc('Data').collection('OrderList').add({'name': 'Cart'});
    firebaseFirestore.collection('LovelyRoom').doc('Data').collection('AddressList').add({'name': 'Address'});
    firebaseFirestore.collection('LovelyRoom').doc('Data').collection('PaymentList').add({'name': 'Payment'});
    firebaseFirestore.collection('LovelyRoom').doc('Data').collection('ReviewList').add({'name': 'Review'});
    firebaseFirestore.collection('LovelyRoom').doc('Data').collection('NotificationList').add({'name': 'Notification'});
  }

  /// read data from firestore
  Stream<QuerySnapshot<Map<String, dynamic>>> readFurnitureData()
  {
    return firebaseFirestore.collection('LovelyRoom').doc('Data').collection('ProductList').snapshots();
  }

  /// delete data from firestore
  OpController opController = Get.put(OpController());
  void deleteFurnitureData()
  {

    firebaseFirestore.collection('LovelyRoom').doc('Data').collection('ProductList').doc('${opController.docId.value}').delete();

  }

}