import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? uid;
  final String? username;
  final String? email;
  final String? photoUrl;
  final String? bio;
  final String? linenumber;
  final List? following;
  final List? followers;

  const User({
    this.uid,
    this.username,
    this.email,
    this.photoUrl,
    this.bio,
    this.linenumber,
    this.following,
    this.followers,
  });

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "username": username,
    "email": email,
    "photoUrl": photoUrl,
    "bio": bio,
    "linenumber": linenumber,
    "followers": followers,
    "following": following,
  };

  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot['uid'],
      username: snapshot['username'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      bio: snapshot['bio'],
      linenumber: snapshot['linenumber'],
      followers: snapshot['followers'],
      following: snapshot['following'],
    );
  }
}


