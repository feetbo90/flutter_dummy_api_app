// To parse this JSON data, do
//
//     final myPost = myPostFromJson(jsonString);

import 'dart:convert';

MyPost myPostFromJson(String str) => MyPost.fromJson(json.decode(str));

String myPostToJson(MyPost data) => json.encode(data.toJson());

class MyPost {
  MyPost({
    required this.id,
    required this.image,
    required this.likes,
    required this.tags,
    required this.text,
    required this.publishDate,
    required this.owner,
  });

  String id;
  String image;
  int likes;
  String tags;
  String text;
  String publishDate;
  String owner;

  factory MyPost.fromJson(Map<String, dynamic> json) => MyPost(
    id: json["id"],
    image: json["image"],
    likes: json["likes"],
    tags: json["tags"],
    text: json["text"],
    publishDate: json["publishDate"],
    owner: json["owner"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "likes": likes,
    "tags": tags,
    "text": text,
    "publishDate": publishDate,
    "owner": owner,
  };
}
