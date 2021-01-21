import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:geocoder/geocoder.dart';

class UserLocation{

  final String docId;
  final String uid;
  // ignore: non_constant_identifier_names
  final GeoPoint LatLng;
  final String venue;

  // ignore: non_constant_identifier_names
  UserLocation({this.uid, this.LatLng, this.venue, this.docId});
}