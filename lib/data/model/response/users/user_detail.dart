// To parse this JSON data, do
//
//     final userDetail = userDetailFromJson(jsonString);

import 'dart:convert';

UserDetail userDetailFromJson(String str) => UserDetail.fromJson(json.decode(str));

String userDetailToJson(UserDetail data) => json.encode(data.toJson());

class UserDetail {
  UserDetail({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.picture,
    required this.gender,
    required this.email,
    required this.dateOfBirth,
    required this.phone,
    required this.location,
    required this.registerDate,
    required this.updatedDate,
  });

  String id;
  String title;
  String firstName;
  String lastName;
  String picture;
  String gender;
  String email;
  DateTime dateOfBirth;
  String phone;
  Location location;
  DateTime registerDate;
  DateTime updatedDate;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
    id: json["id"],
    title: json["title"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    picture: json["picture"],
    gender: json["gender"],
    email: json["email"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    phone: json["phone"],
    location: Location.fromJson(json["location"]),
    registerDate: DateTime.parse(json["registerDate"]),
    updatedDate: DateTime.parse(json["updatedDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "firstName": firstName,
    "lastName": lastName,
    "picture": picture,
    "gender": gender,
    "email": email,
    "dateOfBirth": dateOfBirth.toIso8601String(),
    "phone": phone,
    "location": location.toJson(),
    "registerDate": registerDate.toIso8601String(),
    "updatedDate": updatedDate.toIso8601String(),
  };
}

class Location {
  Location({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.timezone,
  });

  String street;
  String city;
  String state;
  String country;
  String timezone;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    street: json["street"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    timezone: json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "city": city,
    "state": state,
    "country": country,
    "timezone": timezone,
  };
}
