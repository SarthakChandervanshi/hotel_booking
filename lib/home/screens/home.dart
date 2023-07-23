import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotel_booking/home/controller/home_controller.dart';
import 'package:hotel_booking/home/reusable_components.dart';
import 'package:hotel_booking/home/screens/subviews/booked_hotels.dart';
import 'package:hotel_booking/home/screens/subviews/listing_screen.dart';

class Home extends StatefulWidget {
  static const String home = '/home';

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController _homeController = Get.put(HomeController());

  final List<Widget> bottomNavBarItems = [
    const ListingScreen(),
    const BookedHotels()
  ];

  @override
  void dispose() {
    Get.delete<HomeController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F6),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        elevation: 10,
        currentIndex: _homeController.tabIndex.value,
        selectedItemColor: const Color(0xFF1D1D1D),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xFF1D1D1D)),
        unselectedLabelStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey),
        iconSize: 25,
        onTap: (index){
          _homeController.tabIndex.value = index;
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/svg/heart.svg",height: 20,width: 20,color: _homeController.tabIndex.value == 1 ? const Color(0xFF1D1D1D) : Colors.grey,),
              label: "Booked"
          )
        ],
      ),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16,16,16,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomAppBar(),
              const SizedBox(height: 32,),
              Flexible(child: Obx(() => bottomNavBarItems[_homeController.tabIndex.value]))
            ],
          ),
        ),
      ),
    );
  }
}
