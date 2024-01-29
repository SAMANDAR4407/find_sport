import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  final String title;
  final String description;
  final double lat;
  final double long;

  Address({
    required this.title,
    required this.description,
    required this.lat,
    required this.long,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
