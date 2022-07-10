class Filter {
  String? title;
  String? address;
  int? categoryId;
  int? userId;
  int? sectionId;
  int? locationId;

  Filter({
    this.title,
    this.address,
    this.categoryId,
    this.locationId,
    this.sectionId,
    this.userId,
  });

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "address": address == null ? null : address,
        "categorie_id": categoryId == null ? null : categoryId,
        "user_id": userId == null ? null : userId,
        "section_id": sectionId == null ? null : sectionId,
        "location_id": locationId == null ? null : locationId,
      };
}
