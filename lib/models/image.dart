// To parse this JSON data, do
//
//     final image = imageFromJson(jsonString);

import 'dart:convert';

class Image {
  Image({
    this.id,
    this.url,
    this.postId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? url;
  int? postId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"] == null ? null : json["id"],
        url: json["url"] == null ? null : json["url"],
        postId: json["post_id"] == null ? null : json["post_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "url": url == null ? null : url,
        "post_id": postId == null ? null : postId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt,
      };
}
