import 'package:flutter_demo_app/controllers/base_controller.dart';
import 'package:flutter_demo_app/core/router.dart';
import 'package:flutter_demo_app/services/api_service.dart';
import 'package:flutter_demo_app/services/dialog_service.dart';
import 'package:flutter_demo_app/utils/navigator_util.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final ApiService _apiService = Get.find();

  void login(context, String username, String password) {
    setBusy();
    DialogService.showFullLoading(context, title: 'Login In Process');
    Future.delayed(const Duration(seconds: 2), () {
      setIdle();
      DialogService.closeFullLoading(context);
      NavigatorUtil.pushReplacementNamed(context, Routes.index);
    });
  }
}
