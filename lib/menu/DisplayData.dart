import 'package:flutter/material.dart';

class DisplayData extends StatelessWidget {
  final String name, desc, venue, date, time;
  DisplayData({this.name, this.desc, this.venue, this.date, this.time});

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Data'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Card(
                  child: ListTileEvent(
                    data: name,
                    title: 'Event Name',
                    icon: Icons.event,
                  ),
                ),
                Card(
                  child: ListTileEvent(
                    data: desc,
                    title: 'Event Description',
                    icon: Icons.description,
                  ),
                ),
                Card(
                  child: ListTileEvent(
                    data: venue,
                    title: 'Venue',
                    icon: Icons.place,
                  ),
                ),
                Card(
                  child: ListTileEvent(
                    data: date,
                    title: 'Date',
                    icon: Icons.date_range,
                  ),
                ),
                Card(
                  child: ListTileEvent(
                    data: time,
                    title: 'Time',
                    icon: Icons.access_time,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListTileEvent extends StatelessWidget {
  ListTileEvent({this.data, this.title, this.icon});

  final String data, title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      //title: Icon(icon),
      subtitle: Text(
        data,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
