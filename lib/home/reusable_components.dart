import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hotel_booking/home/models/hotel_model.dart';
import 'package:hotel_booking/onboarding/login.dart';
import 'package:hotel_booking/services/firebase_controller.dart';
import 'package:hotel_booking/utils.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current Location",
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9E9E9F),
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_sharp,
                  color: Color(0xFFB5692F),
                  size: 20,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "Gurgaon, India",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                )
              ],
            )
          ],
        ),
        GestureDetector(
          onTap: () async {
            await FirebaseController.signOut();
            Get.offAllNamed(Login.login);
            Utils.showSnackBar("Signed out successfully");
          },
          child: Card(
            elevation: 3,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Image.asset(
                "assets/image/logout.png",
                height: 20,
                width: 20,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class HotelCardTile extends StatelessWidget {
  const HotelCardTile({Key? key, required this.hotelModel, this.callBack})
      : super(key: key);

  final HotelModel hotelModel;
  final Function? callBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onTap: callBack != null ? () => callBack!() : () {},
          overlayColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.2)),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 10,
                  shadowColor: Colors.grey,
                  child: Hero(
                    tag: '${hotelModel.hotelName}${hotelModel.hotelAddress}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: hotelModel.images?[0] ?? "",
                        height: 150,
                        width: double.maxFinite,
                        fit: BoxFit.fill,
                        errorWidget: (context, _, __) => Image.asset("assets/image/placeholder-image.png"),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              hotelModel.hotelName ?? "",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1D1D1D)),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          hotelModel.hotelAddress != null
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
                                            hotelModel.hotelAddress ?? "",
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
                          hotelModel.hotelArea != null
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
                                        "${hotelModel.hotelArea ?? " "} sqft",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF0B0B0B)),
                                      ),
                                    )
                                  ],
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "₹${hotelModel.hotelNewPrice}",
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFB4682C)),
                                children: const [
                                  TextSpan(
                                    text: "/night",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFA5A5A5)),
                                  )
                                ]),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "₹${hotelModel.hotelOldPrice}",
                            style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF989898),
                                    decoration: TextDecoration.lineThrough)
                                .copyWith(height: 1),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key, required this.textEditingController, this.hintText, this.suffixCallback, required this.onChanged})
      : super(key: key);

  final TextEditingController textEditingController;
  final String? hintText;
  final Function? suffixCallback;
  final Function onChanged;

  final OutlineInputBorder _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      controller: textEditingController,
      cursorColor: Colors.black,
      onChanged: (value){
        onChanged(value);
      },
      style: const TextStyle(
          color: Color(0xFF121212), fontSize: 16, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        border: _border,
        focusedBorder: _border,
        errorBorder: _border,
        enabledBorder: _border,
        disabledBorder: _border,
        focusedErrorBorder: _border,
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Image.asset(
            "assets/image/magnifying-glass.png",
            height: 30,
            width: 30,
          ),
        ),
        prefixIconConstraints: const BoxConstraints.tightFor(),
        suffixIconConstraints: const BoxConstraints.tightFor(),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: suffixCallback != null ? () => suffixCallback!() : (){},
              child: Image.asset("assets/image/filter.png",height: 20,width: 20,),
          ),
        )
      ),
    );
  }
}

class DotsIndicator extends StatelessWidget {
  const DotsIndicator(
      {Key? key, required this.length, required this.currentIndex})
      : super(key: key);

  final int length;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (currentIndex == index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 20,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)),
            );
          } else {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 8,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12)),
            );
          }
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 8);
        },
        itemCount: length,
      ),
    );
  }
}

class Amenities extends StatelessWidget {
  const Amenities({Key? key, required this.image, required this.title}) : super(key: key);

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(image,width: 25,height: 25,),
        const SizedBox(width: 4,),
        Text(title,style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Color(0xFFB4682C)),)
      ],
    );
  }
}

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    required this.onPressed,
    required this.title
  }) : super(key: key);

  final Function onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () => onPressed(),
          style: ElevatedButton.styleFrom(
            elevation: 10,
            backgroundColor: const Color(0xFF242424),
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            )
          ),
          child: Text(title,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.white),),
      ),
    );
  }
}


