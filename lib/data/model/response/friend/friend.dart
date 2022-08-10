import 'dart:convert';

Friend friendFromJson(String str) => Friend.fromJson(json.decode(str));

String friendToJson(Friend data) => json.encode(data.toJson());

class Friend {
  Friend({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
