import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_demo_app/core/application.dart';
import 'package:flutter_demo_app/utils/pretty_logger.dart';
import 'package:get/get.dart';

class ApiService extends GetxService {
  static String apiEndpoint = Application.env();

  Dio dio = Dio(BaseOptions(
    baseUrl: apiEndpoint,
    connectTimeout: 60000,
    headers: {
      "accept": "application/json",
      //"Content-Type": "application/x-www-form-urlencoded",
    },
  ));

  void setToken(String token) {
    dio.options.headers.addAll({
      "Authorization": 'Bearer $token',
    });
  }

  void clearToken() {
    dio.options.headers.remove('Authorization');
  }

  void init() {
    PrettyDioLogger logger = PrettyDioLogger();
    logger.responseAddOn = (response) async {
      // try {
      //   if (response.data['loginStatus'] != 1 &&
      //       response.data['loginStatus'] != 0) {
      //     Get.offAndToNamed('/');
      //   }
      // } catch (e) {
      //   return response;
      // }
    };
    dio.interceptors.add(logger);
  }

  Future apiRequest(
      String path, String type, dynamic data, String? baseUrl) async {
    dynamic response;
    if (baseUrl != null) {
      dio.options.baseUrl = baseUrl;
    } else {
      dio.options.baseUrl = apiEndpoint;
    }

    if (type == 'get') {
      response = await dio.get(path, queryParameters: data);
    } else if (type == 'post') {
      response = await dio.post(path, data: data);
    } else if (type == 'put') {
      response = await dio.put(path, data: data);
    } else if (type == 'delete') {
      response = await dio.delete(path, data: data);
    } else if (type == 'patch') {
      response = await dio.patch(path, queryParameters: data);
    } else {
      response = await dio.get(path);
    }
    try {
      var json = jsonDecode(response.toString());
      if (json['status'] == false) {
        // showError('Error', json['msg'].toString());
      }
      return json;
    } catch (e) {
      // showError('Json', 'Invalid Json');
    }
  }
}
