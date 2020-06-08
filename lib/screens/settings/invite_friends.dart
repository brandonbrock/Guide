import 'package:flutter/material.dart';

class InviteFriends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Invite Friends'),
      ),
      body: BodyLayout(),
    );
  }
}

class BodyLayout extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return _myListView(context);
      }
    }

Widget _myListView(BuildContext context) {
      return ListView(
        children: <Widget>[
           ListTile(
            leading: Icon(Icons.message),
            title: Text('Invite by WhatsApp'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
           ListTile(
            leading: Icon(Icons.smartphone),
            title: Text('Invite by SMS'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
           ListTile(
            leading: Icon(Icons.account_box),
            title: Text('Invite by Facebook'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
           ListTile(
            leading: Icon(Icons.photo_camera),
            title: Text('Invite by Instagram'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ],
      );
    }