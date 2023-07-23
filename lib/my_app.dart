import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_booking/home/screens/home.dart';
import 'package:hotel_booking/routes.dart';
import 'package:hotel_booking/services/firebase_controller.dart';

import 'onboarding/login.dart';
import 'onboarding/register.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: FirebaseController.getCurrentUser() != null ? Home.home : Login.login,
            getPages: getRoutes,
          );
        }
        else{
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
