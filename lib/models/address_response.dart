import 'package:json_annotation/json_annotation.dart';

part 'address_response.g.dart';

@JsonSerializable()
class AddressResponse {
  final String? title;
  final String? description;
  final double? lat;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  AddressResponse({
    required this.title,
    required this.description,
    required this.lat,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) => _$AddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressResponseToJson(this);

}

/*
  factory AddressResponse.fromJson(Map<String, dynamic> json) => _$AddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressResponseToJson(this);
*/
