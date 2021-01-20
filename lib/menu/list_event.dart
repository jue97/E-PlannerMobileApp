import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:EPlanner/menu/edit_event.dart';

class ListEvent extends StatefulWidget {
  @override
  _ListEventState createState() => _ListEventState();

  static fromSnapshot(eventSnapshot) {}
}

class _ListEventState extends State<ListEvent> {
  String namaEvent;
  TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (namaEvent == null) {
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
        /*floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ManageEvent()));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          elevation: 5.0,
          color: Colors.blueAccent,
          child: ButtonBar(
            children: [],
          ),
        ),*/
        resizeToAvoidBottomPadding: false,
        body: Container(
          width: size.width * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: TextField(
                  decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
                  controller: searchController,
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      namaEvent = searchController.text.toString();
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
                height: size.height * 0.5,
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
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              deleteEvent(i);
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: () {
                                              /*Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditEvent(snapshot
                                                          .data.docs[i])),
                                            );*/
                                              Navigator.of(context).push(
                                                  new MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          new EditEvent(
                                                              eName: name,
                                                              eDesc:
                                                                  description,
                                                              eVenue: venue,
                                                              eDate: date,
                                                              eTime: time,
                                                              index: snapshot
                                                                  .data
                                                                  .docs[i]
                                                                  .reference)));
                                            },
                                          )
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
              )
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
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ManageEvent()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 5.0,
        color: Colors.blueAccent,
        child: ButtonBar(
          children: [],
        ),
      ),*/
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: size.width * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search), hintText: "Search"),
                controller: searchController,
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    namaEvent = searchController.text.toString();
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
                          //create variable untuk pass data dari page ni
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            deleteEvent(i);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            /*Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditEvent(snapshot
                                                          .data.docs[i])),
                                            );*/
                                            Navigator.of(context).push(
                                                new MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        new EditEvent(
                                                            eName: name,
                                                            eDesc: description,
                                                            eVenue: venue,
                                                            eDate: date,
                                                            eTime: time,
                                                            index: snapshot
                                                                .data
                                                                .docs[i]
                                                                .reference)));
                                          },
                                        )
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
            )
          ],
        ),
      ),
    );
  }

  fetchEvent() {
    return FirebaseFirestore.instance.collection("event").snapshots();
  }

  deleteEvent(id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("event");
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[id].reference.delete();
  }

  fetchEventSort() {
    return FirebaseFirestore.instance
        .collection("event")
        .where("name", isEqualTo: namaEvent)
        .snapshots();
  }
}
