/*
 * @Author: SQS 1491579574@qq.com
 * @Date: 2023-05-22 11:32:22
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-28 09:53:18
 * @FilePath: \study_bug\lib\assembly\OjLine.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// ignore: file_names
import 'package:flutter/material.dart';

class OjLine extends StatelessWidget {
  final String title;
  final String content;
  final String tips;
  final EdgeInsets padding;

  const OjLine({
    Key? key,
    required this.title,
    required this.content,
    this.tips = '',
    this.padding = const EdgeInsets.fromLTRB(16, 8, 16, 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black))),
          Align(
            alignment: Alignment.topLeft,
            child: Text('来源：$tips',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                )),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '标签：$content',
              maxLines: 1,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          const Divider(
              thickness: 1, color: Color.fromARGB(117, 224, 224, 224)),
        ],
      ),
    );
  }
}
