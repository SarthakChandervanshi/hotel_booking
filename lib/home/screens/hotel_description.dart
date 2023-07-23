import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_booking/home/controller/home_controller.dart';
import 'package:hotel_booking/home/reusable_components.dart';
import 'package:hotel_booking/services/firebase_controller.dart';
import 'package:hotel_booking/utils.dart';
import 'package:intl/intl.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:share_plus/share_plus.dart';

class HotelDescription extends StatefulWidget {

  static const String hotelDescription = '/hotel_description';

  HotelDescription({Key? key}) : super(key: key);

  @override
  State<HotelDescription> createState() => _HotelDescriptionState();
}

class _HotelDescriptionState extends State<HotelDescription> {

  final HomeController _homeController = Get.find();
  late final int listIndex;
  RxInt _currentIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    listIndex = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F6),
      bottomSheet: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Price",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Color(0xFFBABABA)),),
                const SizedBox(height: 6),
                RichText(
                  text: TextSpan(
                      text: "₹${_homeController.foundHotels[listIndex].hotelNewPrice}",
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB4682C)),
                      children: const [
                        TextSpan(
                          text: "/night",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFA5A5A5)),
                        )
                      ]),
                ),
              ],
            ),
            const SizedBox(width: 36,),
            Flexible(
              child: CommonButton(
                title: "Reserve Now",
                onPressed: () async {
                  if((_homeController.foundHotels[listIndex].startDate?.isNotEmpty ?? false) && (_homeController.foundHotels[listIndex].endDate?.isNotEmpty ?? false)){
                    bool status = await FirebaseController.addBooking(_homeController.foundHotels[listIndex], FirebaseController.getCurrentUser()?.uid ?? "");
                    if(status){
                      Get.back();
                      _homeController.getData();
                      Utils.showSnackBar("Booking Successful");
                      _homeController.tabIndex.value = 1;
                    }
                  }
                  else{
                    Utils.showSnackBar("Please select your booking date");
                  }
                },
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Hero(
                  tag: '${_homeController.foundHotels[listIndex].hotelName}${_homeController.foundHotels[listIndex].hotelAddress}',
                  child: CarouselSlider(
                      items: _homeController.foundHotels[listIndex].images?.map((image) => CachedNetworkImage(
                        color: Colors.black.withOpacity(0.25),
                        colorBlendMode: BlendMode.darken,
                        fit: BoxFit.fitHeight,
                          imageUrl: image,
                        errorWidget: (context,_,__) => const SizedBox(),
                      )).toList(),
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 1,
                        initialPage: _currentIndex.value,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        onPageChanged: (index,reason){
                          _currentIndex.value = index;
                        },
                        scrollDirection: Axis.horizontal,
                      )
                  ),
                ),
                Positioned(
                  bottom: 30,
                  child: Obx(() => DotsIndicator(
                    length: _homeController.foundHotels[listIndex].images?.length ?? 0,
                    currentIndex: _currentIndex.value,
                  )),
                ),
                Positioned(
                  left: 22,
                  top: 45,
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text(_homeController.foundHotels[listIndex].hotelName ?? "",style: const TextStyle(fontSize: 28,fontWeight: FontWeight.w600,color: Color(0xFF1D1D1D)),)),
                      GestureDetector(
                        onTap: (){
                          Share.share('Hey!, Checkout this hotel: ${_homeController.foundHotels[listIndex].hotelName} ${_homeController.foundHotels[listIndex].hotelAddress}');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey,width: 1)
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.share,color: Color(0xFF1D1D1D),size: 12,),
                              SizedBox(width: 8,),
                              Text("Share",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Color(0xFF1D1D1D)),)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16,),
                  _homeController.foundHotels[listIndex].hotelAddress != null
                      ? Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Color(0xFFABADB3),
                            size: 20,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Flexible(
                            child: Text(
                              _homeController.foundHotels[listIndex].hotelAddress ?? "",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF0B0B0B)),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                    ],
                  )
                      : const SizedBox(),
                  _homeController.foundHotels[listIndex].hotelArea != null
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.home,
                        color: Color(0xFFABADB3),
                        size: 20,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Flexible(
                        child: Text(
                          "${_homeController.foundHotels[listIndex].hotelArea ?? " "} sqft",
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0B0B0B)),
                        ),
                      )
                    ],
                  )
                      : const SizedBox(),
                  const SizedBox(height: 16,),
                  Obx(() => (_homeController.foundHotels[listIndex].booked ?? false) ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFB4682C).withOpacity(0.3)),
                      color: const Color(0xFFF4F3F1),
                    ),
                    padding: const EdgeInsets.all(8),
                      child: Column(
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
                              Text("${_homeController.foundHotels[listIndex].startDate} - ${_homeController.foundHotels[listIndex].endDate}",style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Color(0xFFB4682C)),),
                            ],
                          ),
                        ],
                      ),
                  ) : GestureDetector(
                    onTap: () async {
                      DateTimeRange? result = await showDateRangePicker(
                        context: context,
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                        firstDate: DateTime.now().add(const Duration(days: 10)), // the earliest allowable
                        lastDate: DateTime.now().add(const Duration(days: 365)), // the earliest allowable
                        currentDate: DateTime.now(),
                        saveText: 'Done',
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color(0xFFB4682C),
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  primary: Colors.red, // button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if(result != null){
                        _homeController.foundHotels[listIndex].startDate = DateFormat('dd MMM yyyy').format(result.start);
                        _homeController.foundHotels[listIndex].endDate = DateFormat('dd MMM yyyy').format(result.end);
                        _homeController.foundHotels[listIndex].booked = true;
                        _homeController.foundHotels.refresh();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFB4682C).withOpacity(0.3)),
                        color: const Color(0xFFF4F3F1),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.calendar_month,size: 20,color: Color(0xFFB4682C),),
                          SizedBox(width: 8,),
                          Text("Book Your Dates",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Color(0xFFB4682C)),)
                        ],
                      ),
                    ),
                  ),),
                  const SizedBox(height: 16,),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFFF4F3F1),
                      border: Border.all(color: const Color(0xFFB4682C).withOpacity(0.3))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _homeController.foundHotels[listIndex].amenities!.asMap().entries.map((amenity) => Amenities(image: _homeController.foundHotels[listIndex].amenities?[amenity.key].image ?? "",title: _homeController.foundHotels[listIndex].amenities?[amenity.key].title ?? "",)).toList()
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Text(loremIpsum(words: 150, paragraphs: 3, initWithLorem: true),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Color(0xFFB5B6B6)),)
                ],
              ),
            ),
            const SizedBox(height: 90,)
          ],
        ),
      ),
    );
  }
}
