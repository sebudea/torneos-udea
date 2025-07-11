import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_model.freezed.dart';
part 'team_model.g.dart';

@freezed
class TeamModel with _$TeamModel {
  const factory TeamModel({
    required String id,
    required String name,
    required String faculty,
    required List<String> playerIds,
    @JsonKey(includeFromJson: true, includeToJson: false)
    required DateTime createdAt,
    @JsonKey(includeFromJson: true, includeToJson: false)
    required DateTime updatedAt,
    @Default(false) bool isDeleted,
  }) = _TeamModel;

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamModelFromJson(json);
}
