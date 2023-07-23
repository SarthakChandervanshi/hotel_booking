import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_booking/home/controller/home_controller.dart';
import 'package:hotel_booking/home/models/hotel_model.dart';
import 'package:lottie/lottie.dart';

class BookedHotels extends StatefulWidget {
  const BookedHotels({Key? key}) : super(key: key);

  @override
  State<BookedHotels> createState() => _BookedHotelsState();
}

class _BookedHotelsState extends State<BookedHotels> {

  final HomeController _homeController = Get.find();

  @override
  void initState() {
    super.initState();
    _homeController.getBookedData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(!_homeController.gotBookedHotels.value){
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      else{
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Your Bookings",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600,color: Color(0xFF1D1D1D)),),
            const SizedBox(height: 16,),
            _homeController.bookedHotels.isEmpty ? Flexible(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/image/not_found.png",height: 200,width: 200,),
                    const Text("No Bookings Found",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Color(0xFF1D1D1D)),)
                  ],
                ),
              ),
            ) :
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 12),
                physics: const BouncingScrollPhysics(),
                cacheExtent: 1,
                itemBuilder: (context,index){
                  return BookedHotelCard(
                   hotel: _homeController.bookedHotels[index],
                  );
                },
                separatorBuilder: (context,index){
                  return const SizedBox(height: 16);
                },
                itemCount: _homeController.bookedHotels.length,
              ),
            )
          ],
        );
      }
    });
  }
}

class BookedHotelCard extends StatelessWidget {
  const BookedHotelCard({Key? key, required this.hotel}) : super(key: key);

  final HotelModel hotel;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFFF4F3F1),
            border: Border.all(color: Color(0xFFBE7A4E))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(hotel.hotelName ?? "",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xFF1D1D1D)),),
                  const SizedBox(height: 8,),
                  RichText(
                    text: TextSpan(
                        text: "₹${hotel.hotelNewPrice ?? ""}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB4682C)),
                        children: const [
                          TextSpan(
                            text: "/night",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFA5A5A5)),
                          )
                        ]),
                  ),
                  const SizedBox(height: 16,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Booking Dates",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Color(0xFFB4682C)),),
                      const SizedBox(height: 4,),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.calendar_month,size: 16,color: Color(0xFFB4682C),),
                          const SizedBox(width: 4),
                          Text("${hotel.startDate} - ${hotel.endDate}",style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Color(0xFFB4682C)),),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Lottie.asset("assets/lottie/lottie.json",height: 80,width: 80)
          ],
        ),
      ),
    );
  }
}

