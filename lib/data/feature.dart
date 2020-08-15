import 'package:json_annotation/json_annotation.dart';

part 'feature.g.dart';

@JsonSerializable(nullable: false)
class FeatureList {
  final List<Feature> features;

  FeatureList({this.features});

  factory FeatureList.fromJson(Map<String, dynamic> json) => _$FeatureListFromJson(json);
  Map<String, dynamic> toJson() => _$FeatureListToJson(this);
}


@JsonSerializable(nullable: false)
class Feature {
  final String type;
  final FeatureProperties properties;

  Feature({this.type, this.properties});

  factory Feature.fromJson(Map<String, dynamic> json) => _$FeatureFromJson(json);
  Map<String, dynamic> toJson() => _$FeatureToJson(this);
}

@JsonSerializable(nullable: false)
class FeatureProperties {
  final int objectId;
  final String name;
  final String location;
  final String type;
  final String website;
  final String description;
  final double area;
  final double length;

  FeatureProperties({this.objectId, this.name, this.location, this.type, this.website, this.description, this.area, this.length});

  factory FeatureProperties.fromJson(Map<String, dynamic> json) => _$FeaturePropertiesFromJson(json);
  Map<String, dynamic> toJson() => _$FeaturePropertiesToJson(this);
}