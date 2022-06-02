import 'package:flutter/material.dart';
import 'package:flutter_demo_app/constants/strings.dart';
import 'package:flutter_demo_app/services/storage_manager.dart';
import 'package:get/get.dart';

class AppProvider extends ChangeNotifier {
  String theme = StringUtil.LIGHT_MODE;
  String language = StringUtil.ENG_LANG;

  initValue() {
    changeMode(StorageManger.getConfig(StorageKey.THEME_MODE));
    changLanguage(StorageManger.getConfig(StorageKey.LANG_MODE));
  }

  changeMode(mode) {
    if (mode == StringUtil.DARK_MODE) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
    theme = mode;
    StorageManger.saveConfig(StorageKey.THEME_MODE, theme);
    notifyListeners();
  }

  changLanguage(lang) {
    if (lang == StringUtil.ENG_LANG) {
      var l = const Locale('en', 'US');
      Get.updateLocale(l);
    } else {
      var l = const Locale('zh', 'CN');
      Get.updateLocale(l);
    }
    language = lang;
    StorageManger.saveConfig(StorageKey.LANG_MODE, lang);
    notifyListeners();
  }
}
