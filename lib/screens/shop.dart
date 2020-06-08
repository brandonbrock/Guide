//https://www.youtube.com/watch?v=ZiagJJTqnZQ&list=PLxefhmF0pcPlw2kf-3PAPruUjqDYEEsRb&index=11

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Shop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.all(0.0),
              child: Text(""),
              decoration: BoxDecoration(
                color: Colors.pink
              ),
            ),
            ListTile(
              title: Text('Basket'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Order'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Coupons'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Wish List'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Membership'),
              onTap: () {},
            ),
            ListTile(
              title: Text('My Store'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Wallet'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {},
            ),
          ],

        ),
      ),
      appBar: AppBar(
      title: Text('Shop'),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right:20.0),
          child: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.shopping_basket,
              size: 26.0,
              ),
          ),
          ),
      ],
      ),
      body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  @override 
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  
  Future getTops() async {
      var firestone = Firestore.instance;

      QuerySnapshot tops = await firestone.collection("shop").getDocuments();

      return tops.documents;

    }

    Future getBottoms() async {
      var firestone = Firestore.instance;

      QuerySnapshot bottoms = await firestone.collection("shop/mens/shoes").getDocuments();

      return bottoms.documents;

    }

    Future getShoes() async {
      var firestone = Firestore.instance;

      QuerySnapshot shoes = await firestone.collection("shop/mens/shoes").getDocuments();

      return shoes.documents;

    }

  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getBottoms(),
          builder: (_, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('..loading'),
              );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: Image.network( snapshot.data[index].data["image"],),
                  title: Text(snapshot.data[index].data["name"],
                        style: TextStyle(fontSize: 15), 
                        textAlign: TextAlign.left,),
                  subtitle: Text(snapshot.data[index].data["price"],
                        style: TextStyle(fontWeight: 
                        FontWeight.bold, fontSize: 15),),
                        );
              }
            );
          }
          }
      )
    );
  }
}

