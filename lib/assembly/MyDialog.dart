/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-05 22:52:08
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-16 12:06:38
 * @FilePath: \study_bug\lib\assembly\MyDialog.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// ignore: file_names
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Future<bool?> MyDialog(BuildContext context,
    {String title = '提示',
    String content = '',
    String no_msg = '取消',
    String yes_msg = '确定'}) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        titleTextStyle: const TextStyle(fontSize: 18, color: Colors.black),
        contentTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
        content: SingleChildScrollView(
            child: Column(
          children: <Widget>[Text(content)],
        )),
        actions: <Widget>[
          TextButton(
            child: Text(no_msg),
            onPressed: () => Navigator.of(context).pop(), // 关闭对话框
          ),
          TextButton(
            child: Text(yes_msg),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
