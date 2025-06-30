import 'package:doc_app/core/helpers/extension.dart';
import 'package:json_annotation/json_annotation.dart';
part 'api_error_model.g.dart';

// حسب شو بيرجعلي من جيسون
/* {
"message": "error",
"code": 1
}
*/
@JsonSerializable()
class ApiErrorModel {
  final String? message;
  final int? code;
  @JsonKey(name: 'data')
  final Map<String, dynamic>? dataError;

  ApiErrorModel({this.message, this.code, this.dataError});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  String getAllErrorsMessage() {
    if (dataError.isNullOrEmpty()) return message ?? 'Unknown error';
    final errorMessage = dataError!.entries
        .map((entry) {
          final value = entry.value;
          return "${value.join(', ')}";
        })
        .join('\n');
    return errorMessage;
  }
}
