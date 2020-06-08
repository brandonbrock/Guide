import 'package:flutter/material.dart';

class Payment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Payment'),
      ),
      body: ListView(
        children: <Widget>[
      Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Like'),
            Switch(value: false, onChanged: null),
          ],
        ),
        ),
      ),
      Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Follow'),
            Switch(value: false, onChanged: null),
          ],
        ),
        ),
      ),
      Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Comment'),
            Switch(value: false, onChanged: null),
          ],
        ),
        ),
      ),
      Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Tagged'),
            Switch(value: false, onChanged: null),
          ],
        ),
        ),
      ),
      Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Message'),
            Switch(value: false, onChanged: null),
          ],
        ),
        ),
      ),
      Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Shop'),
            Switch(value: false, onChanged: null),
          ],
        ),
        ),
      ),
        ],
      )
      );
  }
}