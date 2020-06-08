import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:guide/models/user.dart';
import 'package:guide/services/auth.dart';
import 'package:guide/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();

}

class _EditProfileState extends State<EditProfile> {
  //variable for updating profile picture
  File _image;

  //form elements
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String _currentDisplayName = '';
  String _currentBio = '';
  String _currentAvatar = '';
  String _currentName = '';
  String _currentGender = '';
  String _currentLocation = '';

  

  @override
  Widget build(BuildContext context) {


    //getting the image from phone gallery
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image=image;
        print('Image path $_image');
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName=basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask=firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      setState(() {
        print('Profile Pic uploaded');
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Updated')));
      });
    }


  final user = Provider.of<User>(context); 
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          UserData userData = snapshot.data;
          return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
          title: Text('Edit Profile'),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: new FlatButton(
              child: new Text('Cancel', style: new TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: () {Navigator.pop(context);
                },
            ),
              ),
          ],
          ),
          body: Form(
        key: _formKey,
        child:LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportContraints) {
          return Container (
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportContraints.maxHeight,
            ),
                      child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                InkWell(
                  child: (_image!=null)?Image.file(_image):Image.asset('assets/images/defaultprofile.jpg', height: 150,),
                  onTap: () => getImage(),
                  ),
                SizedBox(height: 25),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (input) {
                  setState(() => _currentDisplayName = input);
                },
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Display Name',
                    contentPadding: const EdgeInsets.all(15),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.pink
                        ),
                      borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.pink
                        ),
                      borderRadius: BorderRadius.circular(5),
                      ),
                  )
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Please enter a bio' : null,
                  onChanged: (input) {
                  setState(() => _currentBio = input);
                },
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Bio',
                    contentPadding: const EdgeInsets.all(15),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.pink
                        ),
                      borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.pink
                        ),
                      borderRadius: BorderRadius.circular(5),
                      ),
                  )
                ),
                SizedBox(height: 20,),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (input) {
                  setState(() => _currentName = input);
                },
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Full Name',
                    contentPadding: const EdgeInsets.all(15),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.pink
                        ),
                      borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.pink
                        ),
                      borderRadius: BorderRadius.circular(5),
                      ),
                  )
                ),
                SizedBox(height: 25),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Please enter a Gender' : null,
                  onChanged: (input) {
                  setState(() => _currentGender = input);
                },
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Gender',
                    contentPadding: const EdgeInsets.all(15),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.pink
                        ),
                      borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.pink
                        ),
                      borderRadius: BorderRadius.circular(5),
                      ),
                  )
                ),
                SizedBox(height: 25),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Please enter a Location' : null,
                  onChanged: (input) {
                  setState(() => _currentLocation = input);
                },
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Location',
                    contentPadding: const EdgeInsets.all(15),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.pink
                        ),
                      borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.pink
                        ),
                      borderRadius: BorderRadius.circular(5),
                      ),
                  )
                ),
                SizedBox(height: 25),
                FlatButton(child: Text(
                  'Update',
                  style: TextStyle(
                    fontSize: 20,
                    ),
                  ),
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pink, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(15),
                  textColor: Colors.pink,
                  onPressed: ()  async {
                    uploadPic(context);
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentDisplayName ?? userData.displayName, 
                        _currentBio ?? userData.bio, 
                        _currentAvatar ?? userData.avatar, 
                        _currentName ?? userData.name, 
                        _currentGender ?? userData.gender, 
                        _currentLocation ?? userData.location,
                        );
                        Navigator.pop(context);
                    }
                  }
                ),
            ],
            ),
          ),
        ),
      );
        },
        ) 
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