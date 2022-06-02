import 'package:flutter/material.dart';
import 'package:flutter_demo_app/widgets/full_loading.dart';

class DialogService {
  static void showFullLoading(context, {String title = ''}) {
    Navigator.of(context).push(FullLoading(title: title));
  }

  static void closeFullLoading(context) {
    Navigator.of(context).pop(FullLoading());
  }
}
