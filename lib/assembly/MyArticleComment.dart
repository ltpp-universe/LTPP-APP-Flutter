/*
 * @Author: SQS 1491579574@qq.com
 * @Date: 2023-05-19 14:01:51
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-29 20:24:52
 * @FilePath: \study_bug\lib\assembly\MyArticleComment.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// ignore: file_names
// 文章点赞收藏按钮
import 'package:flutter/material.dart';
import 'package:ltpp/assembly/MyEmpty.dart';
import 'package:ltpp/assembly/MyHeadimage.dart';
import 'package:ltpp/public/Global.dart';
import 'package:ltpp/public/Http.dart';

// ignore: must_be_immutable
class MyArticleComment extends StatefulWidget {
  String id = '';
  MyArticleComment({super.key, required this.id});

  @override
  // ignore: library_private_types_in_public_api
  _MyArticleCommentState createState() => _MyArticleCommentState();
}

class _MyArticleCommentState extends State<MyArticleComment> {
  List comment_list = [];
  bool is_no_more = false;
  bool is_lock = false;
  late List<Widget> comment_list_view = [const SizedBox(height: 6)];

  // ignore: prefer_final_fields
  ScrollController _scrollController = ScrollController();

  void _getdata() async {
    if (!mounted) {
      return;
    }
    if (is_no_more || is_lock) {
      return;
    }
    is_lock = true;
    // ignore: use_build_context_synchronously
    Map<String, dynamic> res =
        await Http.sendPost(context, '/ArticleComment/loadComment', body: {
      'article_id': widget.id,
      'comment_id':
          comment_list.isEmpty ? 0 : comment_list[comment_list.length - 1]['id']
    });
    if (res['data'].length > 0) {
      setState(() {
        comment_list = res['data'];
      });
      is_lock = false;
    } else {
      is_no_more = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _getdata();
    _scrollController.addListener(() {
      if (!is_no_more &&
          !is_lock &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        _getdata();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (comment_list.isEmpty) {
      return MyEmpty();
    }
    for (var tem in comment_list) {
      comment_list_view.add(Row(
        children: [
          TextButton(
              onPressed: () => Global.toUserPage(context, tem['userid'] ?? ''),
              child: MyHeadimage(
                tem['userheadimg'] ?? '',
                height: Global.comment_headimage_len,
                width: Global.comment_headimage_len,
              )),
          // ignore: prefer_interpolation_to_compose_strings
          Text(
            // ignore: prefer_interpolation_to_compose_strings
            (tem['username'] ?? ''),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ));
      comment_list_view.add(Padding(
        padding: const EdgeInsets.fromLTRB(
            Global.main_comment_to_left, 0, Global.default_padding, 0),
        child: Card(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: SelectableText(
                  // ignore: prefer_interpolation_to_compose_strings
                  tem['text'] ?? '',
                ))),
      ));
      for (var tt in tem['touserarray']) {
        comment_list_view.add(Padding(
          padding:
              const EdgeInsets.fromLTRB(Global.main_comment_to_left, 0, 0, 0),
          child: Row(
            children: [
              TextButton(
                  onPressed: () =>
                      Global.toUserPage(context, tem['userid'] ?? ''),
                  child: MyHeadimage(
                    tt['userheadimg'] ?? '',
                    height: Global.comment_headimage_len,
                    width: Global.comment_headimage_len,
                  )),
              Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  (tt['username'] ?? ''),
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ));
        comment_list_view.add(Padding(
            padding: const EdgeInsets.fromLTRB(
                Global.child_comment_to_left, 0, Global.default_padding, 0),
            child: Card(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SelectableText(
                      // ignore: prefer_interpolation_to_compose_strings
                      tt['text'] ?? '',
                    )))));
      }
    }
    comment_list_view.add(const SizedBox(height: Global.default_padding));
    return ListView(controller: _scrollController, children: comment_list_view);
  }
}
