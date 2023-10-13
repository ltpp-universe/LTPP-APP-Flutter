/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-04 15:52:35
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-28 11:13:50
 * @FilePath: \study_bug\lib\views\public\ArticleCommentPage.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// 首页
// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:ltpp/assembly/MyArticleComment.dart';
import 'package:ltpp/public/Global.dart';

// ignore: must_be_immutable
class ArticleCommentPage extends StatelessWidget {
  String id;
  ArticleCommentPage(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              '评论',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: Global.app_bar_font_size),
            ),
            toolbarHeight: Global.app_bar_height,
            centerTitle: true),
        body: SafeArea(child: MyArticleComment(id: id)));
  }
}
