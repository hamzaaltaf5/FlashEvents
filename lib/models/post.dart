import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? title;
  String? description;
  String? uid;
  String? username;
  String? postId;
  final datePublished;
  String? postUrl;
  String? profImage;
  final likes;

  Post({
    this.uid,
    this.username,
    this.title,
    this.description,
    this.postId,
    this.datePublished,
    this.postUrl,
    this.profImage,
    this.likes,
  });

  Map<String, dynamic> toJson() => {
    'description': description,
    'uid': uid,
    'title': title,
    'username': username,
    'postId': postId,
    'datePublished': datePublished,
    'profImage': profImage,
    'likes': likes,
    'postUrl': postUrl,
  };

  static Post fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      username: snapshot['username'],
      uid: snapshot['uid'],
      title: snapshot['title'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      profImage: snapshot['profImage'],
      likes: snapshot['likes'],
      postUrl: snapshot['postUrl'],
    );
  }

}
