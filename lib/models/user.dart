import 'dart:convert';

class User {
  User({
    this.id,
    this.firebaseUid,
    this.name,
    this.tel,
    this.type,
    this.status,
    this.photo,
    this.online,
    this.token,
    this.email,
    this.valide,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? firebaseUid;
  String? name;
  String? tel;
  String? type;
  String? status;
  String? photo;

  int? online;
  String? token;
  String? email;
  int? valide;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        firebaseUid: json["firebaseUID"] == null ? null : json["firebaseUID"],
        name: json["name"] == null ? null : json["name"],
        tel: json["tel"] == null ? null : json["tel"].toString(),
        type: json["type"],
        status: json["status"] == null ? null : json["status"],
        photo: json["photo"],
        online: json["online"] == null ? null : json["online"],
        token: json["token"],
        email: json["email"],
        valide: json["valide"] == null ? null : json["valide"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "firebaseUID": firebaseUid == null ? null : firebaseUid,
        "name": name == null ? null : name,
        "tel": tel == null ? null : tel,
        "type": type,
        "status": status == null ? null : status,
        "photo": photo,
        "online": online == null ? null : online,
        "token": token,
        "email": email,
        "valide": valide == null ? null : valide,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt,
      };
}
