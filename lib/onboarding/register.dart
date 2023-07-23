import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_booking/home/screens/home.dart';
import 'package:hotel_booking/onboarding/reusable_components.dart';
import 'package:hotel_booking/services/firebase_controller.dart';
import 'package:hotel_booking/utils.dart';

import '../home/reusable_components.dart' hide CustomTextField;
import 'login.dart';

class Register extends StatefulWidget {

  static const String register = '/register';

  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.zero,
              elevation: 5,
              child: Image.asset("assets/image/intro_photo.jpg",fit: BoxFit.fill,height: Get.height * 0.4,),
            ),
            const SizedBox(height: 32,),
            const Text("Discover and Find your Perfect Healing Place",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Color(0xFF1D1D1D)),textAlign: TextAlign.center,),
            const Text("Sign up now, and feel the heaven",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey),textAlign: TextAlign.center,),
            const SizedBox(height: 64,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextField(
                textEditingController: _username,
                hintText: "example@gmail.com",
                prefixIcon: const Icon(Icons.person,color: Colors.white,),
              ),
            ),
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextField(
                textEditingController: _password,
                hintText: "***123",
                prefixIcon: const Icon(Icons.password,color: Colors.white,),
                obscure: true,
                showSuffix: true,
              ),
            ),
            const SizedBox(height: 32,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CommonButton(
                onPressed: () async {
                  await FirebaseController.registerUsingEmailPassword(email: _username.text, password: _password.text);
                  if(FirebaseController.getCurrentUser() != null){
                  Get.offAllNamed(Home.home);
                  Utils.showSnackBar("Signed in successfully");
                  }
                },
                title: "Sign Up",
              ),
            ),
            const SizedBox(height: 16,),
            GestureDetector(
              onTap: () => Get.offNamed(Login.login),
              child: const Text("Already have an account, Log In",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey),textAlign: TextAlign.center,),
            ),
          ],
        ),
      ),
    );
  }
}
