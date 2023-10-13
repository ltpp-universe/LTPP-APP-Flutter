/*
 * @Author: SQS 1491579574@qq.com
 * @Date: 2023-05-18 00:23:42
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-19 10:48:51
 * @FilePath: \study_bug\lib\assembly\MyMarkdown.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class MyMarkdown extends StatelessWidget {
  final String data;

  const MyMarkdown({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(data);
  }
}
