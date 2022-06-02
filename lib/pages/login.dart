import 'package:flutter/material.dart';
import 'package:flutter_demo_app/controllers/login_controller.dart';
import 'package:flutter_demo_app/utils/navigator_util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController textEditingController = TextEditingController();
  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        NavigatorUtil.outApp(context);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headline4!,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Email cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Password",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  obscureText: true,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Password cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        minimumSize: const Size.fromHeight(50), //
                      ),
                      onPressed: () {
                        if (!loginController.isBusy) {
                          loginController.login(
                              context, 'username', 'password');
                        }
                      },
                      child: Obx(() => !loginController.isBusy
                          ? const Text('Login')
                          : const SpinKitThreeBounce(
                              color: Colors.white,
                              size: 10,
                            ))),
                ),
                const Spacer(),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
