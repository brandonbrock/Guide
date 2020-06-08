import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guide/screens/dashboard.dart';
import 'package:guide/screens/shop.dart';
import 'package:guide/screens/messages.dart';
import 'package:guide/screens/profile.dart';
import 'package:guide/screens/share.dart';
import 'package:guide/services/auth.dart';

class DashboardMain extends StatefulWidget {
  final AuthService _auth = AuthService();
  @override
  DashboardMainState createState()=> DashboardMainState();
}

class DashboardMainState extends State<DashboardMain> {
  int _currentIndex=0;
  Widget callPage(int currentIndex){
    switch (currentIndex) {
      case 0: return Dashboard();
      case 1: return Shop();
      case 2: return Share();
      case 3: return Messages();
      case 4: return Profile();
        break;
      default: return Dashboard();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: callPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (value){
          _currentIndex=value;
          setState(() {
            
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard),title: Text('Dashboard')),
          BottomNavigationBarItem(icon: Icon(Icons.shop),title: Text('Shop')),
          BottomNavigationBarItem(icon: Icon(Icons.photo_camera),title: Text('Share')),
          BottomNavigationBarItem(icon: Icon(Icons.message),title: Text('Messages')),
          BottomNavigationBarItem(icon: Icon(Icons.account_box),title: Text('Profile')),
        ],
      ),
    );
  }
}