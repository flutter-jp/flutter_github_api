// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_auth_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubAuthEntity _$GithubAuthEntityFromJson(Map<String, dynamic> json) {
  return GithubAuthEntity(
    id: json['id'] as int,
    url: json['url'] as String,
    scopes: (json['scopes'] as List)?.map((e) => e as String)?.toList(),
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$GithubAuthEntityToJson(GithubAuthEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'scopes': instance.scopes,
      'token': instance.token,
    };
