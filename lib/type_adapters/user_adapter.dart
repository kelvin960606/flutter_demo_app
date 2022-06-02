import 'package:flutter_demo_app/services/storage_manager.dart';
import 'package:hive/hive.dart';

part 'user_adapter.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  String? username;
  @HiveField(1)
  String? password;
  @HiveField(2)
  String? createTime;
  User({this.username, this.password, this.createTime});
}
