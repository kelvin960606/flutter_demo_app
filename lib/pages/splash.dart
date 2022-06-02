import 'package:flutter/material.dart';
import 'package:flutter_demo_app/constants/strings.dart';
import 'package:flutter_demo_app/core/router.dart';
import 'package:flutter_demo_app/providers/app_provider.dart';
import 'package:flutter_demo_app/services/storage_manager.dart';
import 'package:flutter_demo_app/utils/navigator_util.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Duration duration = const Duration(seconds: 1);
  _startUp() {
    context.read<AppProvider>().initValue();
    Future.delayed(duration, () {
      if (StorageManger.getConfig(StorageKey.TOKEN_KEY) != null) {
        NavigatorUtil.pushReplacementNamed(context, Routes.index);
      } else {
        NavigatorUtil.pushReplacementNamed(context, Routes.loginpage);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), (() => _startUp()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                duration: duration,
                tween: Tween<double>(begin: 0, end: 100),
                builder: (_, size, __) => Text(
                  'Splash',
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: size,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
