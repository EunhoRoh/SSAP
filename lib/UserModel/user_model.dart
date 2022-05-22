import 'package:cloud_firestore/cloud_firestore.dart';

class FriendModel  {
  String id;
  String image ="https://firebasestorage.googleapis.com/v0/b/yorijori-52f2a.appspot.com/o/defaultProfile.png?alt=media&token=127cd072-80b8-4b77-ab22-a50a0dfa5206";
  String name;
  var timeStamp;

  FriendModel({
    required this.id,
    required this.image,
    required this.name,

    this.timeStamp,
  });

  // data from server parsing
  factory FriendModel.fromMap(map) {
    return FriendModel(
      id: map['id'],
      image: map['image'],
      name: map['name'],

      timeStamp: map['timeStamp'],
    );
  }

  // sending data to server

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'timeStamp': FieldValue.serverTimestamp(),
    };
  }
}