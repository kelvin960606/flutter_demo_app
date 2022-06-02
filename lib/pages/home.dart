import 'package:flutter/material.dart';
import 'package:flutter_demo_app/services/storage_manager.dart';
import 'package:flutter_demo_app/type_adapters/user_adapter.dart';
import 'package:flutter_demo_app/utils/navigator_util.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<User> list = [];
  @override
  void initState() {
    super.initState();
    list = StorageManger.userGetList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Welcome home, ${widget.username}!'),
              for (var item in list) Text(item.username!),
              ElevatedButton(
                  onPressed: () {
                    NavigatorUtil.pushNamed(context, '/home');
                  },
                  child: const Text('Home'))
            ],
          ),
        ),
      ),
    );
  }
}
