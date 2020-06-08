import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:guide/models/feed.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  List<Feed> feedList = [];

  @override
  void initState() {
    super.initState();
    DatabaseReference feedRef = FirebaseDatabase.instance.reference().child("Posts");
    feedRef.once().then((DataSnapshot snap)
    {
      var KEYS = snap.value.keys; //gets the all posts uploaded to database
      var DATA = snap.value;

      feedList.clear();

      for(var eachKey in KEYS) {
        Feed feed = new Feed
        (
          DATA[eachKey]['image'],
          DATA[eachKey]['description'],
          DATA[eachKey]['date'],
          DATA[eachKey]['time'],
          );
          feedList.add(feed);
      }
      setState(() {
        print('Length : $feedList.length');
      });
    });
  }


  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
      title: Text("Guide."),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.search), onPressed: () {} ),
      ],
      ),
      body: Container(
        child: feedList.length == 0 ? new Text("Nothing has been posted") : new ListView.builder(
          itemCount: feedList.length,
          itemBuilder: (_, index)
          {
            return FeedUI(feedList[index].image, feedList[index].description, feedList[index].date, feedList[index].time,);
          }
        )        
      ),
    );
  }
}

Widget FeedUI(String image, String description, String date, String time) {
  return new Card(
    elevation: 10.0,
    margin: EdgeInsets.all(15.0),
    child: new Container(
      padding: new EdgeInsets.all(14.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Image.network(image, fit: BoxFit.cover),
          SizedBox(height: 15.0),
          new Text(
                description,
                textAlign: TextAlign.center,
              ),
          SizedBox(height: 15.0),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                date,
                textAlign: TextAlign.center,
              ),
              new Text(
                time,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ],
      ),
    ),
  );
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return null;
  }
  
}