import 'package:flutter/material.dart';
import 'package:furniture_shopping_app/screens/signin_signup/controller/signupcontroller.dart';
import 'package:furniture_shopping_app/utils/firebase_helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfPassword = TextEditingController();
  TextEditingController txtName = TextEditingController();
  SignupController signupController = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Image.asset('assets/signin/pattern.png'),
              SizedBox(height: 30,),
              Center(
                child: Text(
                  'WELCOME',
                  style: GoogleFonts.actor(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      letterSpacing: 1
                  ),
                ),
              ),
              SizedBox(height: 40,),
              // TODO textfield for name
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: txtName,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  style: GoogleFonts.overpass(letterSpacing: 1,color: Colors.black),
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.keyboard_arrow_down,color: Colors.grey),
                    label: Text('Name',style: GoogleFonts.overpass(color: Colors.grey,fontSize: 15,letterSpacing: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey,width: 1.5)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey,width: 1),
                    ),
                  ),
                ),
              ),
              // TODO textfield for email
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: txtEmail,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  style: GoogleFonts.overpass(letterSpacing: 1,color: Colors.black),
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.keyboard_arrow_down,color: Colors.grey),
                    label: Text('Email',style: GoogleFonts.overpass(color: Colors.grey,fontSize: 15,letterSpacing: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey,width: 1.5)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey,width: 1),
                    ),
                  ),
                ),
              ),
              // TODO textfield for password
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Obx(
                      () => TextFormField(
                    controller: txtPassword,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: signupController.isVisible.value,
                    obscuringCharacter: '#',
                    cursorColor: Colors.black,
                    style: GoogleFonts.overpass(letterSpacing: 1,color: Colors.black),
                    decoration: InputDecoration(
                      suffixIcon: InkWell(onTap: () {
                        signupController.visibilityChangeOfPassword();
                      },child: signupController.isVisible.isFalse?Icon(Icons.visibility_off,color: Colors.grey):Icon(Icons.visibility,color: Colors.grey)),
                      label: Text('Password',style: GoogleFonts.overpass(color: Colors.grey,fontSize: 15,letterSpacing: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey,width: 1.5)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey,width: 1),
                      ),
                    ),
                  ),
                ),
              ),
              // TODO textfield for confirm password
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Obx(
                      () => TextFormField(
                    controller: txtConfPassword,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: signupController.isVisible.value,
                    obscuringCharacter: '#',
                    cursorColor: Colors.black,
                    style: GoogleFonts.overpass(letterSpacing: 1,color: Colors.black),
                    decoration: InputDecoration(
                      suffixIcon: InkWell(onTap: () {
                        signupController.visibilityChangeOfPassword();
                      },child: signupController.isVisible.isFalse?Icon(Icons.visibility_off,color: Colors.grey):Icon(Icons.visibility,color: Colors.grey)),
                      label: Text('Confirm Password',style: GoogleFonts.overpass(color: Colors.grey,fontSize: 15,letterSpacing: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey,width: 1.5)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey,width: 1),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              InkWell(onTap: () async {
                String pass1 = txtPassword.text;
                String confpass = txtConfPassword.text;
                if(pass1==confpass)
                {
                  String email = txtEmail.text;
                  String password = txtPassword.text;
                  String name = txtName.text;
                  String msg = await FirebaseHelper.firebaseHelper.signUp(email: email, password: password, name: name);
                  if(msg=='Success')
                  {
                    signupController.name.value = name;
                    signupController.email.value = email;
                    signupController.password.value = password;
                    Get.back();
                  }
                  else
                  {
                    Get.snackbar('error 401', '$msg');
                  }
                }
                else
                {
                  Get.snackbar('error 401', 'Password and confirm password does not match !');
                }

              },child: signUpBox()),
              SizedBox(height: 5.h,),
              InkWell(
                onTap: () {
                  Get.back();
                  },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have account ? ',style: GoogleFonts.poppins(color: Colors.black54,fontSize: 12,letterSpacing: 1)),
                    Text('Sign In',style: GoogleFonts.poppins(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w500,letterSpacing: 1)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget signUpBox()
  {
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
      height: 6.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text('Sign up',style: GoogleFonts.overpass(color: Colors.white,letterSpacing: 1,fontSize: 13.sp)),
    );
  }

}
