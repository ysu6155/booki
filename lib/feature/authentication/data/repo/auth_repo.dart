import 'package:booki/core/network/dio_helper.dart';
import 'package:booki/core/network/end_points.dart';
import 'package:booki/feature/authentication/data/models/request/register_params.dart';
import 'package:booki/feature/authentication/data/models/response/user_response/user_response.dart';

class AuthRepo {
  static Future<UserResponse> register(RegisterParams params) async {
    try {
      var response = await DioHelper.post(
        endPoints: EndPoints.register,
        body: params.toJson(),
      );
      if (response.statusCode == 201) {
        return UserResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to register ${response.data}');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  static Future<UserResponse> login(RegisterParams params) async {
    try {
      var response = await DioHelper.post(
        endPoints: EndPoints.login,
        body: params.toJson(),
      );
      if (response.statusCode == 200) {
        return UserResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to login ${response.data}');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
