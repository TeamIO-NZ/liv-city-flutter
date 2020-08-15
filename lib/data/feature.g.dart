part of 'feature.dart';

FeatureList _$FeatureListFromJson(Map<String, dynamic> json) {
  List<Feature> features = List.empty(growable: true);
  List.castFrom(json['features']).forEach((element) { features.add(Feature.fromJson(element)); });
  return FeatureList(
    features: features
  );
}

Map<String, dynamic> _$FeatureListToJson(FeatureList list) {
  List<dynamic> features = List.empty(growable: true);
  list.features.forEach((element) { features.add(element.toJson()); });
  return <String, dynamic> {
    'features': features
  };
}

Feature _$FeatureFromJson(Map<String, dynamic> json) {
  return Feature(
      type: json['type'],
      properties: FeatureProperties.fromJson(json['properties']));
}

Map<String, dynamic> _$FeatureToJson(Feature feature) => <String, dynamic>{
      'type': feature.type,
      'properties': feature.properties.toJson()
    };

FeatureProperties _$FeaturePropertiesFromJson(Map<String, dynamic> json) {
  return FeatureProperties(
      objectId: json['OBJECTID'],
      name: json['ReserveName'],
      location: json['Location'],
      type: json['Type'],
      website: json['WebsiteURL'],
      description: json['Description'],
      area: json['SHAPEarea'],
      length: json['SHAPElen']);
}

Map<String, dynamic> _$FeaturePropertiesToJson(FeatureProperties properties) =>
    <String, dynamic>{
      'OBJECTID': properties.objectId,
      'ReserveName': properties.name,
      'Location': properties.location,
      'Type': properties.type,
      'WebsiteURL': properties.website,
      'Description': properties.description,
      'SHAPEarea': properties.area,
      'SHAPElen': properties.length
    };
