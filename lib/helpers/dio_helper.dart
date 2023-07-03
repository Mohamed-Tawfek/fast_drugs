import 'package:dio/dio.dart';
import 'package:fast_drugs/shared/constants/api_constants.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ));
  }

  static Future<Response> postData(
      {required endPoint, Map<String, dynamic>? data, String? token}) async {
    return await dio!.post(endPoint, data: data);
  }

  //
  static Future<Response> getData(
      {required String endPoint,
      String? token,
      String language = 'en',
     }) async {
    return await dio!.get(endPoint);
  }
  //
  // static Future<Response> putData({
  //   required String url,
  //   required Map data,
  //   required String token,
  // }) async {
  //   dio!.options.headers = {
  //     'lang': 'en',
  //     'Content-Type': 'application/json',
  //     'Authorization': token,
  //   };
  //   return await dio!.put(url, data: data);
  // }
}
