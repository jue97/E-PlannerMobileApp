import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListEventS extends StatefulWidget {
  @override
  _ListEventSState createState() => _ListEventSState();
}

class _ListEventSState extends State<ListEventS> {
  String nameEvent;
  TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (nameEvent == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.close,
                  size: 20.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
        resizeToAvoidBottomPadding: false,
        body: Container(
          width: size.width * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search), hintText: "Search"),
                  controller: searchController,
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      nameEvent = searchController.text.toString();
                    });
                  },
                  icon: Icon(Icons.search)),
              SizedBox(
                height: size.height * 0.1,
              ),
              Text(
                "List Event",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent[300]),
              ),
              Container(
                height: size.height * 0.6,
                child: StreamBuilder<QuerySnapshot>(
                  stream: fetchEvent(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return new Container(
                        child: Text("No Data"),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int i) {
                            String name =
                                snapshot.data.docs[i]["name"].toString();
                            String description =
                                snapshot.data.docs[i]["desc"].toString();
                            String venue =
                                snapshot.data.docs[i]["venue"].toString();
                            String date =
                                snapshot.data.docs[i]["date"].toString();
                            String time =
                                snapshot.data.docs[i]["time"].toString();

                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.orangeAccent[100]),
                                width: size.width * 1,
                                height: size.height * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Text(
                                            "Name: ",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            snapshot.data.docs[i]["name"],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Description: ",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            snapshot.data.docs[i]["desc"],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Venue: ",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            snapshot.data.docs[i]["venue"],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Date: ",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            snapshot.data.docs[i]["date"],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Time: ",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            snapshot.data.docs[i]["time"],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.close,
                  size: 20.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
        resizeToAvoidBottomPadding: false,
        body: Container(
          width: size.width * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search), hintText: "Search"),
                  controller: searchController,
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      nameEvent = searchController.text.toString();
                    });
                  },
                  icon: Icon(Icons.search)),
              SizedBox(
                height: size.height * 0.1,
              ),
              Text(
                "List Event",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              Container(
                height: size.height * 0.5,
                child: StreamBuilder<QuerySnapshot>(
                  stream: fetchEventSort(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return new Container(
                        child: Text("No Data"),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int i) {
                            String name =
                                snapshot.data.docs[i]["name"].toString();
                            String description =
                                snapshot.data.docs[i]["desc"].toString();
                            String venue =
                                snapshot.data.docs[i]["venue"].toString();
                            String date =
                                snapshot.data.docs[i]["date"].toString();
                            String time =
                                snapshot.data.docs[i]["time"].toString();

                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.indigoAccent[100]),
                                width: size.width * 1,
                                height: size.height * 0.2,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Text(
                                            "Name: ",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            snapshot.data.docs[i]["name"],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Description: ",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            snapshot.data.docs[i]["desc"],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Venue: ",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            snapshot.data.docs[i]["venue"],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Date: ",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            snapshot.data.docs[i]["date"],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Time: ",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            snapshot.data.docs[i]["time"],
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }

  fetchEvent() {
    return FirebaseFirestore.instance.collection("event").snapshots();
  }

  fetchEventSort() {
    return FirebaseFirestore.instance
        .collection("event")
        .where("name", isEqualTo: nameEvent)
        .snapshots();
  }
}
