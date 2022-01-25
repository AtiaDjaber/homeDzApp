// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

import 'package:home_dz/models/section.dart';

class Category {
  Category({
    this.id,
    this.name,
    this.photo,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.sections,
  });

  int? id;
  String? name;
  String? photo;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Section>? sections;

  // Category copyWith({
  //     int? id,
  //     String name,
  //     dynamic photo,
  //     dynamic description,
  //     dynamic deletedAt,
  //     DateTime createdAt,
  //     DateTime updatedAt,
  //     List<Category> sections,
  //     int categorieId,
  // }) =>
  //     Category(
  //         id: id ?? this.id,
  //         name: name ?? this.name,
  //         photo: photo ?? this.photo,
  //         description: description ?? this.description,
  //         deletedAt: deletedAt ?? this.deletedAt,
  //         createdAt: createdAt ?? this.createdAt,
  //         updatedAt: updatedAt ?? this.updatedAt,
  //         sections: sections ?? this.sections,
  //         categorieId: categorieId ?? this.categorieId,
  //     );

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        photo: json["photo"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        sections: json["sections"] == null
            ? null
            : List<Section>.from(
                json["sections"].map((x) => Section.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "photo": photo,
        "description": description,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "sections": sections == null
            ? null
            : List<dynamic>.from(sections!.map((x) => x.toJson())),
      };
}
