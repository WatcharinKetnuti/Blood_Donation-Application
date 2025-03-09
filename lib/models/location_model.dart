import 'dart:convert';

List<Location> locationFromJson(String str) => List<Location>.from(json.decode(str).map((x) => Location.fromJson(x)));

String locationToJson(List<Location> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Location {
  final String locationId;
  final String locationName;
  final String locationDetail;

  Location({
    required this.locationId,
    required this.locationName,
    required this.locationDetail,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    locationId: json["location_id"],
    locationName: json["location_name"],
    locationDetail: json["location_detail"],
  );

  Map<String, dynamic> toJson() => {
    "location_id": locationId,
    "location_name": locationName,
    "location_detail": locationDetail,
  };
}
