/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-08 10:43:37
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-17 10:19:50
 * @FilePath: \study_bug\lib\assembly\MyLoading.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
import 'package:flutter/material.dart';
import 'package:ltpp/public/Global.dart';

class MyLoading extends StatelessWidget {
  const MyLoading({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              '加载中',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: Global.app_bar_font_size),
            ),
            toolbarHeight: Global.app_bar_height,
            centerTitle: true),
        body: const Center(
          child: CircularProgressIndicator(),
        ));
  }
}
