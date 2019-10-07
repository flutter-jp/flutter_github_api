import 'package:json_annotation/json_annotation.dart';
part 'github_auth_entity.g.dart';

@JsonSerializable()
class GithubAuthEntity {
	final int id;
	final String url;
	final List<String> scopes;
	final String token;

	GithubAuthEntity({
		this.id,
		this.url,
		this.scopes,
		this.token,
	});

	// JSON 转实体
	factory GithubAuthEntity.fromJson(Map<String, dynamic> json) =>
			_$GithubAuthEntityFromJson(json);

	// 实体转 JSON 字典
	Map<String, dynamic> toJson() => _$GithubAuthEntityToJson(this);
}
