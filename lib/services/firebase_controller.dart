import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking/constants.dart';
import 'package:hotel_booking/utils.dart';

import '../home/models/hotel_model.dart';

class FirebaseController {
  static final FirebaseController _singleton = FirebaseController._internal();

  factory FirebaseController() {
    return _singleton;
  }

  FirebaseController._internal();

  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  static User? getCurrentUser(){
    return FirebaseAuth.instance.currentUser;
  }

  static Future<List<HotelModel>> getData(String collectionName) async {
    List<HotelModel> hotels;
    QuerySnapshot querySnapshot =
        await _instance.collection(collectionName).get();
    hotels = querySnapshot.docs
        .map((doc) => HotelModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return hotels;
  }

  static Future<User?> registerUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Utils.showSnackBar("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Utils.showSnackBar("The account already exists for that email.");
      }
      else{
        Utils.showSnackBar(e.message.toString());
      }
    }
    return user;
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utils.showSnackBar("No user found for that email");
      } else if (e.code == 'wrong-password') {
        Utils.showSnackBar("Wrong password provided");
      }
      else{
        Utils.showSnackBar(e.message.toString());
      }
    }

    return user;
  }

  static Future<bool> addBooking(HotelModel hotelModel, String uid) async {

    bool status = false;
    bool hotelExists = false;

    try{
      QuerySnapshot doc = await _instance.collection(Constants.bookingDataCollection).doc(uid).collection(uid).get();
      for(int i = 0 ; i < doc.docs.length ; i++){
        if(doc.docs[i][Constants.hotelName] == hotelModel.hotelName){
          hotelExists = true;
          break;
        }
      }
      if(hotelExists){
        Utils.showSnackBar("Booking already exists for this hotel");
      }
      else{
        await _instance.collection(Constants.bookingDataCollection).doc(uid).collection(uid).add(hotelModel.toJson());
        status = true;
      }
    } on FirebaseException catch(e){
      Utils.showSnackBar(e.message.toString());
    }

    return status;
  }

  static Future<List<HotelModel>> getBookedData(String uid) async {
    List<HotelModel> hotels;
    QuerySnapshot querySnapshot =
    await _instance.collection(Constants.bookingDataCollection).doc(uid).collection(uid).get();
    hotels = querySnapshot.docs
        .map((doc) => HotelModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return hotels;
  }


  static Future<User?> signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
  }
}
