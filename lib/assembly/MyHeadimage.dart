/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-07 08:41:03
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-16 18:02:39
 * @FilePath: \study_bug\lib\assembly\MyHeadimage.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:ltpp/public/Global.dart';

// ignore: must_be_immutable
class MyHeadimage extends StatelessWidget {
  // ignore: unused_field
  String _src = '';
  double _width = Global.chat_headimage_len;
  double _height = Global.chat_headimage_len;

  MyHeadimage(String src, {super.key, double? width, double? height}) {
    _src = src;
    if (width != null) {
      _width = width;
    }
    if (height != null) {
      _height = height;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (_src == null || _src == '') {
      return ClipOval(
          child: Image.asset(
        'images/default/user.png',
        width: _width,
        height: _height,
        fit: BoxFit.cover,
      ));
    }
    return ClipOval(
        child: Image.network(
      _src,
      width: _width,
      height: _height,
      fit: BoxFit.cover,
    ));
  }
}
