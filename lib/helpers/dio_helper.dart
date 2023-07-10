import 'package:dio/dio.dart';
import 'package:fast_drugs/helpers/cash_helper.dart';
import 'package:fast_drugs/shared/constants/api_constants.dart';

class DioHelper {
  static Dio? dio;
  static String? token;
  static init() async {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ));
  }

  static Future<Response> postData(
      {required endPoint, Map<String, dynamic>? data}) async {
    if (token == null) {
      token = await CashHelper.getData(key: 'token');
    }

    return await dio!.post(endPoint,
        data: data,

        options: Options(headers: {"Authorization": "Bearer $token"}));
  }

  //
  static Future<Response> getData({
    required String endPoint,
    String? token,
  }) async {
    if (token == null) {
      token = await CashHelper.getData(key: 'token');
    }
    return await dio!.get(endPoint,
        options: Options(headers: {"Authorization": "Bearer $token"}));
  }

  static Future<Response> putData({
    required String url,
    Map? data,
  }) async {
    if(token==null)
    {
      token =await CashHelper.getData(key: 'token');

    }
    return await dio!.put(
      url,
      data: data,
        options: Options(headers: {"Authorization": "Bearer $token"})
    );
  }

  static Future<Response> patchData({
    required String url,
    Map? data,
  }) async {
    if(token==null)
    {
      token =await CashHelper.getData(key: 'token');

    }
    return await dio!.patch(url, data: data,options: Options(headers: {"Authorization": "Bearer $token"}));
  }

  static Future<Response> delete({
    required String url,
    Map? data,
  }) async {
    if(token==null)
    {
      token =await CashHelper.getData(key: 'token');

    }
    return await dio!.delete(url, data: data,options: Options(headers: {"Authorization": "Bearer $token"}));
  }
}
