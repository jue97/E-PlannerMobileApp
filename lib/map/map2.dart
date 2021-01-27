import 'dart:collection';
//import 'dart:math' show sin, cos, sqrt, atan2;
//import 'package:vector_math/vector_math.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart' as geoCo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map2 extends StatefulWidget {
  final String uid;
  final Function searchAndNavigate;
  Map2({this.uid, this.searchAndNavigate});
  @override
  _Map2State createState() => _Map2State();
}

class _Map2State extends State<Map2> {
  TextEditingController searchController = new TextEditingController();
  String locationEvent;
  GoogleMapController googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Position position;
  Position currentLocation;
  String addressLocation;
  String country;
  String postalCode;
  //Position _currentPosition;
  double earthRadius = 6371000;

  //Using pLat and pLng as dummy location
  //double pLat = 22.8965265;
  //double pLng = 76.2545445;

  //Use Geolocator to find the current location(latitude & longitude)
  //getUserLocation() async {
   // _currentPosition = await Geolocator.getCurrentPosition(
    //    desiredAccuracy: LocationAccuracy.high);
 // }

  /*//Calculating the distance between two points without Geolocator plugin
  getDistance() {
    var dLat = radians(pLat - _currentPosition.latitude);
    var dLng = radians(pLng - _currentPosition.longitude);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(radians(_currentPosition.latitude)) *
            cos(radians(pLat)) *
            sin(dLng / 2) *
            sin(dLng / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = earthRadius * c;
    print(d); //d is the distance in meters
  }*/

  Set<Circle> circles = HashSet<Circle>();

  void getMarkers(double lat, double long) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker _marker = Marker(
        markerId: markerId,
        position: LatLng(lat, long),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(snippet: addressLocation));
    setState(() {
      markers[markerId] = _marker;
    });
  }

  void getCurrentLocation() async {
    Position currentPosition =
        await GeolocatorPlatform.instance.getCurrentPosition();
    setState(() {
      position = currentPosition;
    });
  }

  bool mapToggle = false;
  bool tutorsToggle = false;
  var filterDist;
  var radius3;

  /*Future<LocationData> _getUserLocation;
  Location location = new Location();*/

  LatLng initialPosition = LatLng(2.2214, 102.4531);
  double value;

  Widget userSearchBar = TextFormField(
    textInputAction: TextInputAction.go,
    //style: TextStyle(fontFamily: "Poppins", color: Colors.white),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: "Location",
      //hintStyle:
      //TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 18.0),
    ),
  );

  @override
  void initState() {
    super.initState();
    _setCircles(googleMapController);
    //_getCurrenLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Color(0x44000000),
          iconTheme: IconThemeData(
              //color: Colors.black,
              ),
          title: userSearchBar,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  setState(() {
                    locationEvent = searchController.text.toString();
                  });
                },
                icon: Icon(Icons.search))
          ]),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 550.0,
              child: GoogleMap(
                onTap: (tapped) async {
                  final coordinated =
                      new geoCo.Coordinates(tapped.latitude, tapped.longitude);
                  var address = await geoCo.Geocoder.local
                      .findAddressesFromCoordinates(coordinated);
                  var firstAddress = address.first;
                  getMarkers(tapped.latitude, tapped.longitude);
                  await FirebaseFirestore.instance.collection('location').add({
                    'latitude': tapped.latitude,
                    'longitude': tapped.longitude,
                    'Address': firstAddress.addressLine,
                    'Country': firstAddress.countryName,
                    'PostalCode': firstAddress.postalCode
                  });
                  setState(() {
                    country = firstAddress.countryName;
                    postalCode = firstAddress.postalCode;
                    addressLocation = firstAddress.addressLine;
                  });
                },
                mapType: MapType.hybrid,
                circles: circles,
                compassEnabled: true,
                trafficEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  setState(() {
                    googleMapController = controller;
                  });
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(2.2214, 102.4531), zoom: 15.0),
                markers: Set<Marker>.of(markers.values),
              ),
            ),
            Container(child: Text('Address: $addressLocation')),
            Container(child: Text('PostalCode: $postalCode ')),
            Container(child: Text('Country: $country')),
          ],
        ),
      ),
    );
  }

  void _setCircles(GoogleMapController controller) async {
    //var currentLocation = await Geolocator().getCurrentPosition();
    setState(() {
      circles.add(Circle(
        circleId: CircleId("circle"),
        center: LatLng(currentLocation.latitude, currentLocation.longitude),
        radius: 1000,
        //fillColor: Colors.blueAccent.withOpacity(0.1),
        strokeWidth: 1,
        //strokeColor: Colors.black,
      ));
    });
  }
}
