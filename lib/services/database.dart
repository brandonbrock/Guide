import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guide/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  //adds registered users into a collection with dummy data
  final CollectionReference userCollection = Firestore.instance.collection('users');

  //gets document by userid and gets the data paramenters
  Future<void> updateUserData(String displayName, String bio, String avatar, String name, String gender, String location) async {
    return await userCollection.document(uid).setData({
      'displayName': displayName,
      'bio': bio,
      'avatar': avatar,
      'name': name,
      'gender': gender,
      'location': location,
    });
  }

  //get user data 
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots()
    .map(_userData);
  }

  //userdata from snapshot
  UserData _userData (DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      displayName: snapshot.data['displayName'],
      bio: snapshot.data['bio'],
      avatar: snapshot.data['avatar'],
    );
  } 

}