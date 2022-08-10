// To parse this JSON data, do
//
//     final posts = postsFromJson(jsonString);

import 'dart:convert';

Posts postsFromJson(String str) => Posts.fromJson(json.decode(str));

String postsToJson(Posts data) => json.encode(data.toJson());

class Posts {
  Posts({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
  });

  List<Datum> data;
  int total;
  int page;
  int limit;

  factory Posts.fromJson(Map<String, dynamic> json) => Posts(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    total: json["total"],
    page: json["page"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total": total,
    "page": page,
    "limit": limit,
  };
}

class Datum {
  Datum({
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
  List<String> tags;
  String text;
  DateTime publishDate;
  Owner owner;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    image: json["image"],
    likes: json["likes"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    text: json["text"],
    publishDate: DateTime.parse(json["publishDate"]),
    owner: Owner.fromJson(json["owner"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "likes": likes,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "text": text,
    "publishDate": publishDate.toIso8601String(),
    "owner": owner.toJson(),
  };
}

class Owner {
  Owner({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.picture,
  });

  String id;
  String title;
  String firstName;
  String lastName;
  String picture;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json["id"],
    title: json["title"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    picture: json["picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "firstName": firstName,
    "lastName": lastName,
    "picture": picture,
  };
}

