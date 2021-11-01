import 'package:json_annotation/json_annotation.dart';

part 'profile_item.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileItem{
  ProfileItem();

  String userName = "";
  String password = "";
  String loginWith = "normal";
  String tokenThirdParty = "null";

  factory ProfileItem.fromJson(Map<String, dynamic> json) => _$ProfileItemFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileItemToJson(this);
}