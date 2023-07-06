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

  static Future<Response> putData({
    required String url,
      Map? data,
   }) async {

    return await dio!.put(url, data: data);
  }
  static Future<Response> patchData({
    required String url,
      Map? data,
   }) async {

    return await dio!.patch(url, data: data);
  }
  static Future<Response> delete({
    required String url,
      Map? data,
   }) async {

    return await dio!.delete(url, data: data);
  }


}
