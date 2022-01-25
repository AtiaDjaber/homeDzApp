// To parse this JSON data, do
//
//     final section = sectionFromJson(jsonString);

import 'dart:convert';

class Section {
  Section({
    this.id,
    this.name,
    this.categorieId,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  int? categorieId;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Section.fromRawJson(String str) => Section.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        categorieId: json["categorie_id"] == null ? null : json["categorie_id"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "categorie_id": categorieId == null ? null : categorieId,
        "description": description,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
