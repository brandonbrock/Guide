import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:guide/models/feed.dart';
import 'package:guide/models/user.dart';
import 'package:guide/screens/settings/about.dart';
import 'package:guide/screens/settings/edit_profile.dart';
import 'package:guide/screens/settings/help.dart';
import 'package:guide/screens/settings/invite_friends.dart';
import 'package:guide/screens/settings/notifications.dart';
import 'package:guide/screens/settings/payment.dart';
import 'package:guide/screens/settings/privacy.dart';
import 'package:guide/screens/settings/security.dart';
import 'package:guide/services/auth.dart';
import 'package:guide/services/database.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final AuthService _auth = AuthService();
  
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

  @override

  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);  
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          UserData userData = snapshot.data;
          return Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text(""),
                  decoration: BoxDecoration(
                    color: Colors.pink
                  ),
                ),
                ListTile(
                  title: Text('Invite Friends'),
                  onTap: () {
                    Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => InviteFriends()
                    ));
                    },
                ),
                ListTile(
                  title: Text('Notifications'),
                  onTap: () {
                    Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => Notifications()
                    ));
                  },
                ),
                ListTile(
                  title: Text('Privacy'),
                  onTap: () {
                    Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => Privacy()
                    ));
                  },
                ),
                ListTile(
                  title: Text('Security'),
                  onTap: () {
                    Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => Security()
                    ));
                  },
                ),
                ListTile(
                  title: Text('Payment'),
                  onTap: () {
                    Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => Payment()
                    ));
                  },
                ),
                ListTile(
                  title: Text('Help'),
                  onTap: () {
                    Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => Help()
                    ));
                  },
                ),
                ListTile(
                  title: Text('About'),
                  onTap: () {
                   Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => About()
                    ));
                  },
                ),
                ListTile(
                  title: Text('Logout'),
                  onTap: () async {
                   await _auth.signOut();
                  },
                ),
              ],

            ),
          ),
          appBar: AppBar(
          title: Text('Profile'),
          
          actions: <Widget>[
            new FlatButton(
              child: new Text('Edit Profile', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: () {
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => EditProfile()
                    ));
              },
            )
          ],
          ),

          body: Container(
            child: Card(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/defaultprofile.jpg', height: 150,),
                      SizedBox(height: 15),
                      Text(userData.displayName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      SizedBox(height: 10),
                      Text(
                        userData.bio,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        ),
                      SizedBox(height: 5),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text("0",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  ),
                                  ),
                                  Text("Followers")
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text("0",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  ),
                                  ),
                                  Text("Following")
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text("0",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  ),
                                  ),
                                  Text("Likes")
                                ],
                              )
                            ],
                          ),
                          ),
                      ),
                      Expanded(
                        child: feedList.length == 0 ? new Text("Nothing has been posted") : new ListView.builder(
              itemCount: feedList.length,
              itemBuilder: (_, index)
              {
                return FeedUI(feedList[index].image, feedList[index].description, feedList[index].date, feedList[index].time,);
              }
            )
                      ),
                    ],
                  ),
                ),
              ),
          ),
        );
        } else {
          return Center(
              child: Text('..loading'),
              );
        }
        
      }
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
