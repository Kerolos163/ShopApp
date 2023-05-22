import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: "https://student.valuxapps.com/api/",
      receiveDataWhenStatusError: true,
    ));
  }

  static GetData(
      {required String url,
      Map<String, dynamic>? query,
      String lang = 'en',
      String? Authorization}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': Authorization ?? "",
    };
    return await dio.get(url, queryParameters: query);
  }

  static PostData(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String lang = 'en',
      String? Authorization}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': Authorization,
    };
    return await dio.post(url, queryParameters: query, data: data);
  }
  static PutData(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String lang = 'en',
      String? Authorization}) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': Authorization,
    };
    return await dio.put(url, queryParameters: query, data: data);
  }
}
