import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart' as geoCo;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  final String uid;
  final Function searchAndNavigate;
  MapsPage({this.uid, this.searchAndNavigate});

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  TextEditingController searchController = new TextEditingController();
  GoogleMapController googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Position position;
  String addressLocation;
  String country;
  String postalCode;
  String _resultAddress;
  LatLng _markerLocation;
  LatLng _userLocation;
  String locationEvent;

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

  Widget userSearchBar = TextFormField(
    textInputAction: TextInputAction.go,
    style: TextStyle(fontFamily: "Poppins", color: Colors.white),
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: "Search",
      hintStyle:
          TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 18.0),
    ),
  );

  fetchLocationSort() {
    return FirebaseFirestore.instance
        .collection("location")
        .where("address", isEqualTo: locationEvent)
        .snapshots();
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    if (locationEvent == null) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Color(0x44000000),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            title: userSearchBar,
            actions: <Widget>[
              IconButton(
                  onPressed: (){
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
                height: 400.0,
                child: GoogleMap(
                  onTap: (tapped) async {
                    final coordinated = new geoCo.Coordinates(
                        tapped.latitude, tapped.longitude);
                    var address = await geoCo.Geocoder.local
                        .findAddressesFromCoordinates(coordinated);
                    var firstAddress = address.first;
                    getMarkers(tapped.latitude, tapped.longitude);
                    await FirebaseFirestore.instance
                        .collection('location')
                        .add({
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
                  mapType: MapType.normal,
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
              Text(
                _resultAddress ?? " Place Marker on the map",
                style: TextStyle(fontFamily: "Poppins", fontSize: 15.0),
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text("Get My Location Address"),
                    onPressed: () async {if(_userLocation != null){
                    //getSetAddress(geoCo.Geocoder.local
                    //.findAddressesFromCoordinates(_userLocation.latitude,_userLocation.longitude));}
                    }
                     } ),
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                    child: Text("Get Marker Address"),
                    onPressed: () async {
                      if (_markerLocation != null) {
                        // getSetAddress(Geo.Coordinates(_markerLocation.latitude,_markerLocation.longitude));}
                      }
                    }),
              ),
              
            ],
          ),
        ),
      );
    }

    /*Future<LocationData> getUserLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.requestService();
    if(!_serviceEnabled){
      _serviceEnabled = await location.requestService();
      if(!_serviceEnabled){
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied){
      _permissionGranted = await location.requestPermission();
      if(_permissionGranted != PermissionStatus.granted){
        return null;
      }
    }
    final result =  await location.getLocation();
    _userLocation = LatLng(result.latitude, result.longitude);
    return result;
  }

  getSetAddress(Geo.Coordinates coordinates) async {
    final addresses = await Geo.Geocoder.local.findAddressesFromCoordinates(coordinates);
    setState(() {
      _resultAddress = addresses.first.addressLine;
    });
  }

  searchAndNavigate() async {

      Geolocator().placemarkFromAddress(searchAddress).then((result) {
        mapController.animateCamera(
            CameraUpdate.newCameraPosition(CameraPosition(
                target: LatLng(
                    result[0].position.longitude, result[0].position.longitude),
                zoom: 10.0
            )));
      });
  }*/

   
  return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Color(0x44000000),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: userSearchBar,
          actions: <Widget>[
           /* IconButton(
                 //onPressed: widget.SearchPlaceWidget,
                icon: Icon(Icons.search))*/
          ]),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 400.0,
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
                mapType: MapType.normal,
                compassEnabled: true,
                trafficEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  setState(() {
                    googleMapController = controller;
                  });
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        2.2214, 102.4531),
                    zoom: 15.0),
                markers: Set<Marker>.of(markers.values),
              ),
            ),
            Text(
              _resultAddress ?? " Place Marker on the map",
              style: TextStyle(fontFamily: "Poppins", fontSize: 15.0),
            ),
      
          ],
        ),
      ),
    );
  }
   @override
    void dispose() {
      super.dispose();
    }
  }

