class HotelModel {
  List<String>? images;
  List<Amenities>? amenities;
  String? hotelName;
  String? hotelAddress;
  String? hotelArea;
  String? hotelNewPrice;
  String? hotelOldPrice;
  bool? booked;
  String? startDate;
  String? endDate;

  HotelModel(
      {this.images,
        this.amenities,
        this.hotelName,
        this.hotelAddress,
        this.hotelArea,
        this.hotelNewPrice,
        this.hotelOldPrice,
        this.booked,
        this.startDate,
        this.endDate
      });

  HotelModel.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
    if (json['amenities'] != null) {
      amenities = <Amenities>[];
      json['amenities'].forEach((v) {
        amenities!.add(new Amenities.fromJson(v));
      });
    }
    hotelName = json['hotel_name'];
    hotelAddress = json['hotel_address'];
    hotelArea = json['hotel_area'];
    hotelNewPrice = json['hotel_new_price'];
    hotelOldPrice = json['hotel_old_price'];
    booked = json['booked'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['images'] = images;
    if (amenities != null) {
      data['amenities'] = amenities!.map((v) => v.toJson()).toList();
    }
    data['hotel_name'] = hotelName;
    data['hotel_address'] = hotelAddress;
    data['hotel_area'] = hotelArea;
    data['hotel_new_price'] = hotelNewPrice;
    data['hotel_old_price'] = hotelOldPrice;
    data['booked'] = booked;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    return data;
  }
}

class Amenities {
  String? image;
  String? title;

  Amenities({this.image, this.title});

  Amenities.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['image'] = image;
    data['title'] = title;
    return data;
  }
}