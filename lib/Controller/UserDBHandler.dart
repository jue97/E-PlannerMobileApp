
//import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:EPlanner/models/NewUser.dart';
//import 'package:sampleproject/models/UserLocation.dart';

class DatabaseService {
  final String uid;
  // final String verified;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('user');
  final CollectionReference eventCollection = FirebaseFirestore.instance.collection('event');
  final CollectionReference locationCollection = FirebaseFirestore.instance.collection('location');
  DatabaseService({this.uid});

  Future createUser(NewUser user) async {
    try {
      await userCollection.doc(user.id).set(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  NewUser _newUserDataFromSnapshot(DocumentSnapshot snapshot) {
    return NewUser(
        id: uid,
        name: snapshot.data()['username'],
        email: snapshot.data()['email'],
        phoneNum: snapshot.data()['phoneNum'],
        userType: snapshot.data()['userType'],
        verified: snapshot.data()['verified']);
  }

  /* UserLocation _newLocationDataFromSnapshot(DocumentSnapshot snapshot)
  {
    return UserLocation(
      docId: snapshot.data['docID'],
      uid: snapshot.data['id'],
      LatLng: snapshot.data['LatLng'],
      venue: snapshot.data['venue']
    );
  }

  Stream<UserLocation> get locationData{
    return locationCollection.doc(uid).snapshots().map(_newLocationDataFromSnapshot);
  }*/

  Stream<NewUser> get userData {
    return userCollection.doc(uid).snapshots().map(_newUserDataFromSnapshot);
  }
}
