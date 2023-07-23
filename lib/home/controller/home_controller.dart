import 'package:get/get.dart';
import 'package:hotel_booking/services/firebase_controller.dart';

import '../../constants.dart';
import '../models/hotel_model.dart';

enum SelectBy{
  Hotel,
  Location
}

class HomeController extends GetxController{
  List<HotelModel> hotels = [
    // HotelModel(
    //     images: [
    //       "https://www.tajhotels.com/content/dam/luxury/hotels/taj-palace-delhi/images/at_a_glance/16x7/Website-Banner-Facade.jpg/_jcr_content/renditions/cq5dam.web.1280.1280.jpeg",
    //       "https://www.tajhotels.com/content/dam/luxury/hotels/taj-palace-delhi/images/at_a_glance/16x7/Website-Banner-Lobby.jpg/jcr:content/renditions/cq5dam.web.1280.1280.jpeg",
    //       "https://cf.bstatic.com/xdata/images/hotel/max1024x768/336042201.jpg?k=3d256f2235057c458ddb63b6ba10baa02815f0bfc4f9a0ca286e3b87107d338b&o=&hp=1"
    //     ],
    //     hotelName: "Taj Palace",
    //     hotelAddress: "New Delhi, India",
    //     hotelArea: "1000",
    //     hotelNewPrice: "8000",
    //     hotelOldPrice: "10,000",
    //   amenities: [
    //     Amenities(image: "assets/image/bed.png", title: "4 Bedroom"),
    //     Amenities(image: "assets/image/bathtub.png", title: "4 Bathroom"),
    //     Amenities(image: "assets/image/earth.png", title: "1000 sqft"),
    //   ],
    //   booked: false
    // ),
    // HotelModel(
    //     images: [
    //       "https://www.theasiacollective.com/wp-content/uploads/2020/03/Taj-Lake-Palace-3.jpg",
    //       "https://www.oberoihotels.com/-/media/oberoi-hotels/website-images/The-Oberoi-Udaivilas-udaipur/Room-and-Suites/Luxury-Suite/overview-new/Udaivilas---Luxury-Suite-Drawing-Room.jpg",
    //       "https://www.oberoihotels.com/-/media/oberoi-hotels/website-images/the-oberoi-udaivilas-udaipur/dining/overview/restaurant-1.jpg?w=836&hash=ac9fe9d3c2f85ad6d4063a98b78d4dd8"
    //     ],
    //     hotelName: "The Oberoi Udaivilas",
    //     hotelAddress: "Udaipur, Rajasthan",
    //     hotelArea: "1200",
    //     hotelNewPrice: "5000",
    //     hotelOldPrice: "6500",
    //     amenities: [
    //       Amenities(image: "assets/image/bed.png", title: "3 Bedroom"),
    //       Amenities(image: "assets/image/bathtub.png", title: "3 Bathroom"),
    //       Amenities(image: "assets/image/earth.png", title: "1200 sqft"),
    //     ],
    //     booked: false
    // ),
    // HotelModel(
    //   images: [
    //     "https://www.theasiacollective.com/wp-content/uploads/2020/03/Taj-Aravali-Resort-Spa.jpg",
    //     "https://www.tajhotels.com/content/dam/luxury/hotels/taj-aravali/gallery/TAU_Grill2_2833.jpg/jcr:content/renditions/cq5dam.web.756.756.jpeg",
    //     "https://www.tajhotels.com/content/dam/luxury/hotels/taj-aravali/gallery/TAU_Add1_9340.jpg/jcr:content/renditions/cq5dam.web.756.756.jpeg"
    //   ],
    //   hotelName: "Taj Aravali Resort",
    //   hotelAddress: "Udaipur, Rajasthan",
    //   hotelArea: "800",
    //   hotelNewPrice: "3000",
    //   hotelOldPrice: "4500",
    //     amenities: [
    //       Amenities(image: "assets/image/bed.png", title: "2 Bedroom"),
    //       Amenities(image: "assets/image/bathtub.png", title: "2 Bathroom"),
    //       Amenities(image: "assets/image/earth.png", title: "800 sqft"),
    //     ],
    //     booked: false
    // ),
    // HotelModel(
    //   images: [
    //     "https://www.holidify.com/images/cmsuploads/compressed/327679014_20220223171722.jpg",
    //     "https://cache.marriott.com/content/dam/marriott-renditions/DELWI/delwi-executive-7734-hor-clsc.jpg?output-quality=70&interpolation=progressive-bilinear&downsize=*:423px",
    //     "https://cache.marriott.com/content/dam/marriott-renditions/DELWI/delwi-king-suite-bedroom-5437-hor-clsc.jpg?output-quality=70&interpolation=progressive-bilinear&downsize=*:423px"
    //   ],
    //   hotelName: "The Westin Gurgaon",
    //   hotelAddress: "Gurgaon, Delhi NCR",
    //   hotelArea: "1250",
    //   hotelNewPrice: "3712",
    //   hotelOldPrice: "4320",
    //     amenities: [
    //       Amenities(image: "assets/image/bed.png", title: "2 Bedroom"),
    //       Amenities(image: "assets/image/bathtub.png", title: "2 Bathroom"),
    //       Amenities(image: "assets/image/earth.png", title: "1250 sqft"),
    //     ],
    //     booked: false
    // ),
    // HotelModel(
    //   images: [
    //     "https://www.theasiacollective.com/wp-content/uploads/2020/03/The-Leela-Palace-1.jpg",
    //     "https://www.theleela.com/prod/content/assets/styles/aio_banner_image_webp/public/aio-banner/dekstop/Pay-two-stay-three-offer-at-leela-hotels.jpg.webp?VersionId=ZwMCw.MuqvokngYNdgLziTf.JhXaHtdR&itok=C0hxVgsG",
    //     "https://www.theleela.com/prod/content/assets/styles/tl_webp/public/2023-03/the-leela-kovalam-hotel.jpg.webp?VersionId=mZl4_W44UtuMzZ3sFaDkm5PDitt1H34i&itok=ClHpKGOb"
    //   ],
    //   hotelName: "Leela Palace",
    //   hotelAddress: "Udaipur, Rajasthan",
    //   hotelArea: "1200",
    //   hotelNewPrice: "8000",
    //   hotelOldPrice: "8500",
    //     amenities: [
    //       Amenities(image: "assets/image/bed.png", title: "3 Bedroom"),
    //       Amenities(image: "assets/image/bathtub.png", title: "3 Bathroom"),
    //       Amenities(image: "assets/image/earth.png", title: "1200 sqft"),
    //     ],
    //     booked: false
    // ),
    // HotelModel(
    //   images: [
    //     "https://www.theasiacollective.com/wp-content/uploads/2020/03/Rambagh-Palace-2.jpg",
    //     "https://www.tajhotels.com/content/dam/luxury/rambagh-palace/16x7/Welcome-4-crop.jpg/jcr:content/renditions/cq5dam.web.323.323.jpeg",
    //     "https://www.tajhotels.com/content/dam/luxury/rambagh-palace/3x2/TRPJ_SawaiMAnSingh221_Bedroom_1706-3x2.jpg/jcr:content/renditions/cq5dam.web.323.323.jpeg"
    //   ],
    //   hotelName: "Rambhag Palace",
    //   hotelAddress: "Jaipur, Rajasthan",
    //   hotelArea: "950",
    //   hotelNewPrice: "6000",
    //   hotelOldPrice: "7000",
    //     amenities: [
    //       Amenities(image: "assets/image/bed.png", title: "1 Bedroom"),
    //       Amenities(image: "assets/image/bathtub.png", title: "1 Bathroom"),
    //       Amenities(image: "assets/image/earth.png", title: "950 sqft"),
    //     ],
    //     booked: false
    // ),
    // HotelModel(
    //   images: [
    //     "https://www.theasiacollective.com/wp-content/uploads/2020/03/The-Oberoi-Rajvilas-Jaipur-1.jpg",
    //     "https://www.oberoihotels.com/-/media/oberoi-hotels/website-images/The-Oberoi-Rajvilas-jaipur/Room-and-Suites/Premier-Room-with-Private-Garden/overview-new/TORV-premier-room-with-private-garden-906x450-01.jpg",
    //     "https://www.oberoihotels.com/-/media/oberoi-hotels/website-images/The-Oberoi-Rajvilas-jaipur/Room-and-Suites/Royal-Tent/overview-new/_MG_7884.jpg"
    //   ],
    //   hotelName: "Oberoi RajVilas",
    //   hotelAddress: "Jaipur, Rajasthan",
    //   hotelArea: "1500",
    //   hotelNewPrice: "9000",
    //   hotelOldPrice: "11000",
    //     amenities: [
    //       Amenities(image: "assets/image/bed.png", title: "2 Bedroom"),
    //       Amenities(image: "assets/image/bathtub.png", title: "2 Bathroom"),
    //       Amenities(image: "assets/image/earth.png", title: "1500 sqft"),
    //     ],
    //     booked: false
    // ),
    // HotelModel(
    //   images: [
    //     "https://www.theasiacollective.com/wp-content/uploads/2020/03/JW-Marriott-Resort-Spa-1.jpg",
    //     "https://jw-marriott-resort-spa.hotels-rajasthan.com/data/Pics/OriginalPhoto/13356/1335607/1335607055/jw-marriott-resort-spa-jaipur-pic-2.JPEG",
    //     "https://jw-marriott-resort-spa.hotels-rajasthan.com/data/Pics/OriginalPhoto/10807/1080751/1080751003/jw-marriott-resort-spa-jaipur-pic-1.JPEG"
    //   ],
    //   hotelName: "JW Mariott",
    //   hotelAddress: "Kukas, Rajasthan",
    //   hotelArea: "1200",
    //   hotelNewPrice: "7500",
    //   hotelOldPrice: "9000",
    //     amenities: [
    //       Amenities(image: "assets/image/bed.png", title: "2 Bedroom"),
    //       Amenities(image: "assets/image/bathtub.png", title: "2 Bathroom"),
    //       Amenities(image: "assets/image/earth.png", title: "1200 sqft"),
    //     ],
    //     booked: false
    // ),
    // HotelModel(
    //   images: [
    //     "https://www.theasiacollective.com/wp-content/uploads/2020/03/The-Taj-Mahal-Palace-1.jpg",
    //     "https://cf.bstatic.com/xdata/images/hotel/max1280x900/176113777.jpg?k=982b8710d50b0e5b6e2db2b275928784748b993a039a1c3b1257e58b19a235fc&o=&hp=1",
    //     "https://cf.bstatic.com/xdata/images/hotel/max1280x900/103703163.jpg?k=760f615013b8331e247fcd22e5a6c98be3a2dc24f664c74021c28dc820acbaaf&o=&hp=1"
    //   ],
    //   hotelName: "Taj Mahal Palace",
    //   hotelAddress: "Mumbai, India",
    //   hotelArea: "1350",
    //   hotelNewPrice: "8000",
    //   hotelOldPrice: "9500",
    //     amenities: [
    //       Amenities(image: "assets/image/bed.png", title: "3 Bedroom"),
    //       Amenities(image: "assets/image/bathtub.png", title: "3 Bathroom"),
    //       Amenities(image: "assets/image/earth.png", title: "1350 sqft"),
    //     ],
    //     booked: false
    // ),
    // HotelModel(
    //   images: [
    //     "https://www.theasiacollective.com/wp-content/uploads/2020/03/The-St.-Regis-Mumbai-1.jpg",
    //     "https://static.toiimg.com/img/51742471/Master.jpg",
    //     "https://cache.marriott.com/content/dam/marriott-renditions/BOMXR/bomxr-mekong-2750-hor-clsc.jpg?output-quality=70&interpolation=progressive-bilinear&downsize=1846px:*"
    //       ],
    //   hotelName: "ST. Regis",
    //   hotelAddress: "Mumbai, Maharashtra",
    //   hotelArea: "1200",
    //   hotelNewPrice: "5000",
    //   hotelOldPrice: "6500",
    //     amenities: [
    //       Amenities(image: "assets/image/bed.png", title: "2 Bedroom"),
    //       Amenities(image: "assets/image/bathtub.png", title: "2 Bathroom"),
    //       Amenities(image: "assets/image/earth.png", title: "1200 sqft"),
    //     ],
    //     booked: false
    // ),
    // HotelModel(
    //   images: [
    //     "https://www.theasiacollective.com/wp-content/uploads/2020/03/Soho-House-Mumbai-1.jpg",
    //     "https://res.cloudinary.com/soho-house/image/upload/f_auto,q_auto,fl_progressive:steep,w_800/t_dc_base/sitecore-prod/images/dotcom-sites/house-pages/mumbai/2023-house-page-update/02_mumbai_homepage_43.jpg",
    //     "https://res.cloudinary.com/soho-house/image/upload/f_auto,q_auto,fl_progressive:steep,w_800/t_dc_base/sitecore-prod/images/dotcom-sites/house-pages/mumbai/2023-house-page-update/07_mumbai_homepage_43.jpg"
    //   ],
    //   hotelName: "SOHO House",
    //   hotelAddress: "Mumbai, India",
    //   hotelArea: "1100",
    //   hotelNewPrice: "5500",
    //   hotelOldPrice: "8300",
    //     amenities: [
    //       Amenities(image: "assets/image/bed.png", title: "2 Bedroom"),
    //       Amenities(image: "assets/image/bathtub.png", title: "2 Bathroom"),
    //       Amenities(image: "assets/image/earth.png", title: "1100 sqft"),
    //     ],
    //     booked: false
    // ),
    // HotelModel(
    //   images: [
    //     "https://www.theasiacollective.com/wp-content/uploads/2020/03/Sujan-Sher-Bagh-1.jpg",
    //     "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/6d/93/7e/the-imperial-suite.jpg?w=900&h=-1&s=1",
    //     "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/22/6d/93/78/the-library.jpg?w=900&h=-1&s=1"
    //   ],
    //   hotelName: "Sujan Sher Bagh",
    //   hotelAddress: "Sawai Madhopur, Rajasthan",
    //   hotelArea: "950",
    //   hotelNewPrice: "3500",
    //   hotelOldPrice: "5500",
    //     amenities: [
    //       Amenities(image: "assets/image/bed.png", title: "1 Bedroom"),
    //       Amenities(image: "assets/image/bathtub.png", title: "1 Bathroom"),
    //       Amenities(image: "assets/image/earth.png", title: "950 sqft"),
    //     ],
    //     booked: false
    // ),
    // HotelModel(
    //   images: [
    //     "https://t-cf.bstatic.com/xdata/images/hotel/max1024x768/93744161.webp?k=81804c0d5e14e8e200f6d27d0c7071f687f2ee1b7e5861ffbfb6c731dd63ede2&o=",
    //     "https://res.cloudinary.com/simplotel/image/upload/x_0,y_12,w_1536,h_864,r_0,c_crop,q_80,fl_progressive/w_825,f_auto,c_fit/evolve-back-kuruba-safari-lodge-kabini/Kabini-Safari_Hut_Dining-1536x889_pylczo",
    //     "https://res.cloudinary.com/simplotel/image/upload/x_215,y_0,w_3875,h_2906,r_0,c_crop,q_80,fl_progressive/w_1237,f_auto,c_fit/evolve-back-kabini/Romantic_Dng_K_f8u08r"
    //   ],
    //   hotelName: "Evolve Back",
    //   hotelAddress: "Mysore, India",
    //   hotelArea: "2000",
    //   hotelNewPrice: "15000",
    //   hotelOldPrice: "18000",
    //     amenities: [
    //       Amenities(image: "assets/image/bed.png", title: "4 Bedroom"),
    //       Amenities(image: "assets/image/bathtub.png", title: "4 Bathroom"),
    //       Amenities(image: "assets/image/earth.png", title: "2000 sqft"),
    //     ],
    //     booked: false
    // ),
  ];

  RxBool gotData = false.obs;
  RxBool gotBookedHotels = false.obs;

  RxList<HotelModel> foundHotels = <HotelModel>[].obs;
  RxList<HotelModel> bookedHotels = <HotelModel>[].obs;

  Rx<SelectBy> selectBy = SelectBy.Hotel.obs;

  RxInt tabIndex = 0.obs;

  List<HotelModel> filterByHotel(String value){
    return foundHotels.where((element) => element.hotelName?.toLowerCase().contains(value.toLowerCase()) ?? false).toList();
  }

  List<HotelModel> filterByLocation(String value){
    return foundHotels.where((element) => element.hotelAddress?.toLowerCase().contains(value.toLowerCase()) ?? false).toList();
  }

  Future<void> getData() async {
    gotData.value = false;
    hotels = await FirebaseController.getData(Constants.hotelDataCollection);
    foundHotels.value = hotels;
    gotData.value = true;
  }

  Future<void> getBookedData() async {
    gotBookedHotels.value = false;
    bookedHotels.value = await FirebaseController.getData(Constants.bookingDataCollection);
    gotBookedHotels.value = true;
  }
}