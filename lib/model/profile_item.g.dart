// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileItem _$ProfileItemFromJson(Map<String, dynamic> json) => ProfileItem()
  ..userName = json['userName'] as String
  ..password = json['password'] as String
  ..loginWith = json['loginWith'] as String
  ..tokenThirdParty = json['tokenThirdParty'] as String;

Map<String, dynamic> _$ProfileItemToJson(ProfileItem instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'password': instance.password,
      'loginWith': instance.loginWith,
      'tokenThirdParty': instance.tokenThirdParty,
    };
