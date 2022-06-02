import 'package:flutter_demo_app/services/api_service.dart';
import 'package:get/get.dart';

class InitializeService {
  static void init() async {
    ApiService apiService = Get.put(ApiService());
    apiService.init();
  }
}
