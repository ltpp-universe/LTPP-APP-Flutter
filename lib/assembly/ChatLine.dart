/*
 * @Author: SQS 1491579574@qq.com
 * @Date: 2023-05-22 11:32:22
 * @LastEditors: 18855190718 1491579574@qq.com
 * @LastEditTime: 2023-09-16 23:01:02
 * @FilePath: \study_bug\lib\assembly\ChatLine.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:ltpp/assembly/MyHeadimage.dart';

class ChatLine extends StatelessWidget {
  final String title;
  final bool online;
  final String tips;
  final EdgeInsets padding;
  final String headimage;

  const ChatLine({
    Key? key,
    required this.title,
    required this.online,
    required this.headimage,
    this.tips = '',
    this.padding = const EdgeInsets.fromLTRB(16, 8, 16, 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                MyHeadimage(headimage),
                Text('  $title',
                    style: online
                        ? const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent)
                        : const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
              ]),
              Text(tips, style: const TextStyle(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(
              thickness: 1, color: Color.fromARGB(117, 224, 224, 224)),
        ],
      ),
    );
  }
}
