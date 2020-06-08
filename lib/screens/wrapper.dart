import 'package:flutter/cupertino.dart';
import 'package:guide/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:guide/models/user.dart';
import 'package:guide/services/dashboard_main.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return DashboardMain();
    }
    
  }
}