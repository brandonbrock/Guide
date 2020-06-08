import 'package:flutter/material.dart';
import 'package:guide/services/auth.dart';
import 'package:guide/screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().user,
          child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Guide',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: Wrapper()
      ),
    );
  }
}