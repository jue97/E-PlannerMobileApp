import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:EPlanner/Controller/Handler.dart';
import 'package:EPlanner/Controller/UserDBHandler.dart';
import 'package:EPlanner/Shared/loading.dart';
import 'package:EPlanner/View/home/AdminHome.dart';
import 'package:EPlanner/View/home/OrganizerHome.dart';
import 'package:EPlanner/View/home/StudentHome.dart';
import 'package:EPlanner/models/NewUser.dart';
import 'package:EPlanner/screen/splashScreen.dart';
import 'package:overlay_support/overlay_support.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

//void main() => runApp(MyApp());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(OverlaySupport(child: MyApp()));
}

/*Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}*/

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
 
  /*FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String title = "title";
  String helper = "helper";

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          title = message['notification']['title'];
          helper = "you have new notification";
        });
        print("onMessage: $message");
        showOverlayNotification((context) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: SafeArea(
              child: ListTile(
                leading: SizedBox.fromSize(
                    size: const Size(40, 40),
                    child: ClipOval(
                        child: Container(
                      color: Colors.black,
                    ))),
                title: Text(message['notification']['title']),
                subtitle: Text(message['notification']['body']),
                trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      OverlaySupportEntry.of(context).dismiss();
                    }),
              ),
            ),
          );
        }, duration: Duration(milliseconds: 4000));
        print(message['notification']['title']);
        // _showItemDialog(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        setState(() {
          title = message['data']['title'];
          helper = "you have open notification";
        });
        // _navigateToItemDetail(message);
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
//root

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        //User kat sini maksudnye Firebaseuser kalau dalam firestore lama
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            // check sama ada user firebase exist atau tak
            final String userId = snapshot.data.uid; // amik userid
            return StreamBuilder<NewUser>(
                // NewUser ni dari model
                stream: DatabaseService(uid: userId)
                    .userData, // get useData from DBServices
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Loading();
                  } else {
                    NewUser userData = snapshot.data;
                    if (userData.userType == 'Organizer') {
                      return OrganizerHome();
                    } else if (userData.userType == 'Student' &&
                        userData.verified == 'Yes') {
                      return newMethod();
                    }
                    return AdminHome();
                  }
                });
            //_getHomeLocation(uid: snapshot.data.uid);
            //return HomePage(uid: snapshot.data.uid);
          }
          return Handler();
        });
  }

  newMethod() => StudentHome();
}
