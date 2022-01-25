// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

import 'package:home_dz/models/image.dart';
import 'package:home_dz/models/section.dart';

import 'category.dart';
import 'location.dart';
import 'user.dart';

class Post {
  Post({
    this.id,
    this.title,
    this.photo,
    this.status,
    this.description,
    this.address,
    this.userId,
    this.longutide,
    this.latitude,
    this.categorieId,
    this.sectionId,
    this.locationId,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.location,
    this.category,
    this.section,
    this.user,
    this.images,
  });

  int? id;
  String? title;
  String? photo;
  String? status;
  dynamic? description;
  String? address;
  num? longutide;
  num? latitude;
  int? categorieId;
  int? userId;
  int? sectionId;
  int? locationId;
  num? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  Location? location;
  Category? category;
  Section? section;
  User? user;
  List<Image>? images;

  factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        photo: json["photo"] == null ? null : json["photo"],
        status: json["status"] == null ? null : json["status"],
        description: json["description"],
        address: json["address"] == null ? null : json["address"],
        userId: json["user_id"] == null ? null : json["user_id"],
        longutide: json["longutide"],
        latitude: json["latitude"],
        categorieId: json["categorie_id"] == null ? null : json["categorie_id"],
        sectionId: json["section_id"] == null ? null : json["section_id"],
        locationId: json["location_id"] == null ? null : json["location_id"],
        price: json["price"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        section:
            json["section"] == null ? null : Section.fromJson(json["section"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "status": status == null ? null : status,
        "description": description,
        "address": address == null ? null : address,
        "user_id": userId == null ? null : userId,
        "longutide": longutide,
        "latitude": latitude,
        "categorie_id": categorieId == null ? null : categorieId,
        "section_id": sectionId == null ? null : sectionId,
        "location_id": locationId == null ? null : locationId,
        "price": price,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "images": images == null
            ? null
            : List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}
