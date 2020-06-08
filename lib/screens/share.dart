//https://www.youtube.com/watch?v=Ze5A_sRL6ww&list=PLxefhmF0pcPlw2kf-3PAPruUjqDYEEsRb&index=10

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:guide/services/dashboard_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class Share extends StatefulWidget 
{
  State<StatefulWidget> createState() 
  {
    return _ShareState();
  }
}

class _ShareState extends State<Share>
{
  File sampleImage; 
  String url; //image
  String myValue; //description
  final formKey = new GlobalKey<FormState>();


  //when the image is pressed the mobile phone gallery will open
  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
  }

  //simple form validation
  bool validateAndSave() {
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
  }

  void uploadStatusImage() async {
    if(validateAndSave()){
      //creates collection for database
      final StorageReference postImageRef = FirebaseStorage.instance.ref().child('Feed');
      var timeKey = new DateTime.now();

      //upload the file
      final StorageUploadTask uploadTask = postImageRef.child(timeKey.toString() + ".jpg").putFile(sampleImage);

      //get url and store in database
      var imgUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = imgUrl.toString();
      print("Image URL = " + url);

      goToHomePage();
      saveToDatabase(url);

    }

  }

  //define variables for database
  void saveToDatabase(url) {
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('d, MM, yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    //set date and to current time and date
    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    //create database
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "image": url,
      "description": myValue,
      "date": date,
      "time": time,
    };
    
    ref.child("Posts").push().set(data);

  }

  //once post is posted reroute to dashboard 
  void goToHomePage() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return new DashboardMain();
    }
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: new Center(
        //display photo from mobile phone gallery
        child: sampleImage == null? Text('Select an Image'): enableUpload(),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Add Image',
        child: new Icon(Icons.add_a_photo),
        ),
    );
  }

//method for user interface to save code space
Widget enableUpload() {
  return Container(
    child: new Form(
      key: formKey,
    child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Image.file(sampleImage, height: 300.0, width: 600.0,),
          SizedBox(height: 10.0,),
          TextFormField(
            decoration: new InputDecoration(
              labelText: 'Description',
            ),
            validator: (value) {
              return value.isEmpty ? 'Please enter a description for your post!' : null;
            },
            onSaved: (value) {
              return myValue = value;
            }
          ),
          SizedBox(height: 10.0,),
          RaisedButton(
            elevation: 10.0,
            child: Text('Add a New Post'),
            textColor: Colors.black,
            color: Colors.pink,
            onPressed: uploadStatusImage,
          ),
      ],
      ),
    ),
    ),
    );

}
}