import 'dart:ffi';

import 'package:get/get.dart';
import 'package:hotel_booking/home/screens/home.dart';
import 'package:hotel_booking/home/screens/hotel_description.dart';
import 'package:hotel_booking/onboarding/login.dart';

import 'onboarding/register.dart';

final getRoutes = [
  GetPage(
    name: Home.home,
    page: () => const Home(),
  ),
  GetPage(
    name: HotelDescription.hotelDescription,
    page: () => HotelDescription(),
  ),
  GetPage(
    name: Login.login,
    page: () => const Login(),
  ),
  GetPage(
    name: Register.register,
    page: () => const Register(),
  ),

];
