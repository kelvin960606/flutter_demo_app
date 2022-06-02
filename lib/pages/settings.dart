import 'package:flutter/material.dart';
import 'package:flutter_demo_app/constants/strings.dart';
import 'package:flutter_demo_app/core/router.dart';
import 'package:flutter_demo_app/providers/app_provider.dart';
import 'package:flutter_demo_app/utils/navigator_util.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<AppProvider>().theme;
    final lang = context.watch<AppProvider>().language;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('theme'.tr, style: Theme.of(context).textTheme.headline5!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(theme == StringUtil.DARK_MODE ? 'dark'.tr : 'light'.tr,
                        style: Theme.of(context).textTheme.subtitle1!),
                    Switch(
                        value: theme == StringUtil.DARK_MODE,
                        onChanged: (v) {
                          context.read<AppProvider>().changeMode(
                              v ? StringUtil.DARK_MODE : StringUtil.LIGHT_MODE);
                        }),
                  ],
                ),
                Text('language'.tr,
                    style: Theme.of(context).textTheme.headline5!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        lang == StringUtil.ENG_LANG
                            ? 'english'.tr
                            : 'chinese'.tr,
                        style: Theme.of(context).textTheme.subtitle1!),
                    Switch(
                        value: lang == StringUtil.ENG_LANG,
                        onChanged: (v) {
                          context.read<AppProvider>().changLanguage(
                              v ? StringUtil.ENG_LANG : StringUtil.CH_LANG);
                        }),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      minimumSize: const Size.fromHeight(50), //
                    ),
                    onPressed: () {
                      NavigatorUtil.pushReplacementNamed(
                          context, Routes.loginpage);
                    },
                    child: const Text('Logout')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
