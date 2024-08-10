/*
 * @Author: SQS 1491579574@qq.com
 * @Date: 2023-05-18 00:23:42
 * @LastEditors: 18855190718 1491579574@qq.com
 * @LastEditTime: 2023-09-16 21:43:53
 * @FilePath: \study_bug\lib\assembly\VideoMiddleware.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
import 'package:flutter/cupertino.dart';
import 'package:ltpp/assembly/MyVideo.dart';
import 'package:ltpp/assembly/MyVideoFabulousAndCollectionButton.dart';

// ignore: must_be_immutable
class VideoMiddleware extends StatefulWidget {
  Map vide_data = {};
  // ignore: type_init_formals
  VideoMiddleware(Map this.vide_data, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _VideoMiddlewareState createState() => _VideoMiddlewareState();
}

class _VideoMiddlewareState extends State<VideoMiddleware> {
  Map _vide_data = {};

  @override
  void initState() {
    super.initState();
    _vide_data = widget.vide_data;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyVideo(_vide_data),
        Positioned(
            bottom: 4,
            left: 0,
            right: 0,
            child:
                MyVideoFabulousAndCollectionButton(id: _vide_data['id'] ?? '',url: _vide_data['url']))
      ],
    );
  }
}
