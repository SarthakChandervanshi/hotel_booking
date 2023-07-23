import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_booking/home/controller/home_controller.dart';
import 'package:hotel_booking/home/reusable_components.dart';
import 'package:hotel_booking/home/screens/hotel_description.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({Key? key}) : super(key: key);

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {

  final TextEditingController _textEditingController = TextEditingController();
  final HomeController _homeController = Get.find();

  Timer? timer;

  void openSearchSelectionBottomSheet(){
    Get.bottomSheet(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Select search by: ",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500,color: Color(0xFF1D1D1D)),),
              Obx(() => RadioListTile(
                isThreeLine: false,
                dense: true,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                contentPadding: EdgeInsets.zero,
                title: const Text("Hotel",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Color(0xFF1D1D1D)),),
                value: SelectBy.Hotel,
                activeColor: const Color(0xFFB4682C),
                groupValue: _homeController.selectBy.value,
                onChanged: (SelectBy? selectBy){
                  _homeController.selectBy.value = selectBy!;
                  Get.back();
                },
              ),),
              Obx(() => RadioListTile(
                isThreeLine: false,
                dense: true,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: const Color(0xFFB4682C),
                contentPadding: EdgeInsets.zero,
                title: const Text("Location",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Color(0xFF1D1D1D)),),
                value: SelectBy.Location,
                groupValue: _homeController.selectBy.value,
                onChanged: (SelectBy? selectBy){
                  _homeController.selectBy.value = selectBy!;
                  Get.back();
                },
              ))
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16)
            )
        ),
        enableDrag: true,
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.white
    );
  }

  @override
  void initState() {
    super.initState();
    _homeController.getData();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(!_homeController.gotData.value){
        return const Center(child: CircularProgressIndicator());
      }
      else{
        return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                textEditingController: _textEditingController,
                hintText: "Search here...",
                suffixCallback: (){
                  FocusScope.of(context).unfocus();
                  openSearchSelectionBottomSheet();
                },
                onChanged: (String value){
                  /// Will only run if length of text entered is 3 minimum
                  if(value.length >= 3){
                    if(timer?.isActive ?? false) timer?.cancel();
                    timer = Timer(const Duration(milliseconds: 500), (){
                      if(_homeController.selectBy.value == SelectBy.Hotel){
                        _homeController.foundHotels.value = _homeController.filterByHotel(value);
                      }
                      else{
                        _homeController.foundHotels.value = _homeController.filterByLocation(value);
                      }
                    });
                  }

                  if(value.isEmpty){
                    _homeController.foundHotels.value = _homeController.hotels;
                  }
                },
              ),
              const SizedBox(height: 16),
              Obx((){
                if(_homeController.foundHotels.isEmpty){
                  return Flexible(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset("assets/image/not_found.png",height: 200,width: 200,),
                          const Text("No Result Found",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Color(0xFF1D1D1D)),)
                        ],
                      ),
                    ),
                  );
                }
                else{
                  return Expanded(
                    child: ListView.separated(
                      cacheExtent: 1,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context,index){
                        return HotelCardTile(
                          hotelModel: _homeController.foundHotels[index],
                          callBack: (){
                            FocusScope.of(context).unfocus();
                            Get.toNamed(HotelDescription.hotelDescription, arguments: index);
                          },
                        );
                      },
                      separatorBuilder: (context,index){
                        return const SizedBox(height: 16);
                      },
                      itemCount: _homeController.foundHotels.length,
                    ),
                  );
                }
              })
            ],
          );
      }
    });
  }
}
