import 'package:flutter_demo_app/type_adapters/user_adapter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class UserCreateRes {
  int success;
  String msg;
  UserCreateRes({this.success = 1, this.msg = ''});
}

class StorageManger {
  static late Box<User> Users;
  static late Box Config;

  static Future<void> initHive() async {
    var databasesPath = await getApplicationDocumentsDirectory();
    Hive.init(databasesPath.path);
    Hive.registerAdapter(UserAdapter());

    Users = await Hive.openBox<User>('users');
    Config = await Hive.openBox('config');
  }

  static getConfig(String key) {
    return Config.get(key);
  }

  static void saveConfig(String key, dynamic value) {
    Config.put(key, value);
  }

  static void userCreate(username, password, createTime) {
    var cc =
        User(username: username, password: password, createTime: createTime);
    Users.add(cc);
  }

  static User? userGet(clientid) {
    if (Users.get(clientid) != null) {
      var cc1 = Users.get(clientid);
      return cc1;
    } else {
      return null;
    }
  }

  static List<User> userGetList() {
    var res = Users.values.toList();
    List<User> cc = res.cast<User>();
    return cc;
  }

  static void userDel(clientid) {
    Users.delete(clientid);
  }
}
