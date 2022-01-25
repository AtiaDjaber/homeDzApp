import 'dart:convert';

import 'package:home_dz/models/user.dart';

class Comment {
  Comment({
    this.id,
    this.text,
    this.createdAt,
    this.updatedAt,
    this.post_id,
    this.user,
  });

  int? id;
  String? text;
  User? user;
  int? post_id;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"] == null ? null : json["id"],
        post_id: json["post_id"] == null ? null : json["post_id"],
        text: json["text"] == null ? null : json["text"].toString(),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "text": text == null ? null : text,
        "post_id": text == null ? null : post_id,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt,
      };
}
