/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-04 19:32:07
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-28 10:40:13
 * @FilePath: \study_bug\lib\assembly\OneLineBox.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// 封装列表一行的显示内容
import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../assembly/MyCard.dart';
import '../public/Global.dart';
import 'KeepAliveWrapper.dart';

// ignore: must_be_immutable
class OneLineBox extends StatefulWidget {
  // ignore: non_constant_identifier_names
  String _title = '';
  String _content = '';
  // ignore: non_constant_identifier_names
  late Uint8List _img;
  double _height = 200;
  // ignore: non_constant_identifier_names, unused_field
  String _to_page_name = '';
  // ignore: non_constant_identifier_names
  OneLineBox(String title, String content,
      {super.key, Uint8List? img, String? to_page_name, double? height}) {
    if (img != null) {
      _img = img;
    }
    if (to_page_name != null) {
      _to_page_name = to_page_name;
    }
    if (height != null) {
      _height = height;
    }
    _title = title;
    _content = content;
  }
  @override
  // ignore: library_private_types_in_public_api
  _OneLineBoxState createState() =>
      // ignore: no_logic_in_create_state
      _OneLineBoxState(_title, _content, _img, _to_page_name, _height);
}

// ignore: unused_element
class _OneLineBoxState extends State<OneLineBox>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String _title = '';
  String _content = '';
  // ignore: non_constant_identifier_names, unused_field
  String _to_page_name = '';

  // ignore: unused_field
  late Uint8List _img;

  _OneLineBoxState(String title, String content, Uint8List img,
      String to_page_name, double height) {
    // ignore: unnecessary_null_comparison
    if (to_page_name != null) {
      _to_page_name = to_page_name;
    }
    // ignore: unnecessary_null_comparison
    if (img == null) {
      _img = Global.getOneImage()!;
    } else {
      _img = img;
    }
    _title = title;
    _content = content;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MyCard(
      height: widget._height,
      is_no_back_color: true,
      child: KeepAliveWrapper(
          child: Stack(
        children: [
          // 背景图片
          Positioned.fill(
              // ignore: unnecessary_null_comparison
              child: Image.memory(
            _img,
            fit: BoxFit.cover,
          )),
          // 顶部文字
          Positioned(
            top: 10.0,
            left: 10.0,
            right: 10.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.6),
                    color: const Color.fromARGB(135, 255, 255, 255),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Text(_title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ),
                ),
                const SizedBox(height: 6.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.6),
                    color: const Color.fromARGB(135, 255, 255, 255),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        _content,
                        maxLines: 8,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
