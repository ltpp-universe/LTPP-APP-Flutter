/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-04 19:32:07
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-28 10:40:13
 * @FilePath: \study_bug\lib\assembly\OneLineApp.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// APP列表一行的显示内容

import 'package:flutter/material.dart';
import '../assembly/MyCard.dart';
import 'KeepAliveWrapper.dart';

// ignore: must_be_immutable
class OneLineApp extends StatefulWidget {
  // ignore: non_constant_identifier_names
  String _title = '';
  String _content = '';
  // ignore: non_constant_identifier_names
  late String _img;
  double _height = 200;
  // ignore: non_constant_identifier_names, unused_field
  String _to_page_name = '';
  // ignore: non_constant_identifier_names
  OneLineApp(String title, String content, String img,
      {super.key, String? to_page_name, double? height}) {
    if (to_page_name != null) {
      _to_page_name = to_page_name;
    }
    if (height != null) {
      _height = height;
    }
    _img = img;
    _title = title;
    _content = content;
  }
  @override
  // ignore: library_private_types_in_public_api
  _OneLineAppState createState() =>
      // ignore: no_logic_in_create_state
      _OneLineAppState(_title, _content, _img, _to_page_name, _height);
}

// ignore: unused_element
class _OneLineAppState extends State<OneLineApp>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  _OneLineAppState(String title, String content, String img,
      String to_page_name, double height) {}

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
              child: Image.network(
            widget._img,
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
                    child: Text(widget._title,
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
                        widget._content,
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
