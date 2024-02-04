/*
 * @Author: SQS 1491579574@qq.com
 * @Date: 2023-05-19 14:01:51
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-19 14:34:17
 * @FilePath: \study_bug\lib\assembly\MyFollow.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// ignore: file_names
// 文章点赞收藏按钮
import 'package:flutter/material.dart';
import 'package:ltpp/assembly/MyDialog.dart';
import 'package:ltpp/public/Http.dart';

// ignore: must_be_immutable
class MyFollowButton extends StatefulWidget {
  String id = '';
  bool is_love = false;
  bool is_fabulous = false;
  MyFollowButton(
      {super.key,
      required this.id,
      required this.is_love,
      required this.is_fabulous});

  @override
  // ignore: library_private_types_in_public_api
  _MyFollowButtonState createState() => _MyFollowButtonState();
}

class _MyFollowButtonState extends State<MyFollowButton> {
  void _collection() async {
    if (!mounted) {
      return;
    }
    Map<String, dynamic> res = await Http.sendPost(
        '/Article/collectionOneArticle',
        context: context,
        body: {
          'article_id': widget.id,
        });
    if (res['code'] == 1) {
      // ignore: use_build_context_synchronously
      MyDialog(context, content: res['msg']);
      setState(() {
        widget.is_love = true;
      });
    }
  }

  void _delCollection() async {
    if (!mounted) {
      return;
    }
    Map<String, dynamic> res = await Http.sendPost('/Article/deleteLoveArticle',
        context: context,
        body: {
          'article_id': widget.id,
        });
    if (res['code'] == 1) {
      // ignore: use_build_context_synchronously
      MyDialog(context, content: res['msg']);
      setState(() {
        widget.is_love = false;
      });
    }
  }

  void _fabulous() async {
    if (!mounted) {
      return;
    }
    // ignore: use_build_context_synchronously
    Map<String, dynamic> res = await Http.sendPost(
        '/Article/fabulousOneArticle',
        context: context,
        body: {
          'article_id': widget.id,
        });

    if (res['code'] == 1) {
      // ignore: use_build_context_synchronously
      MyDialog(context, content: res['msg']);
      setState(() {
        widget.is_fabulous = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 36),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.is_fabulous
              ? Container(
                  margin: const EdgeInsets.only(right: 36),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {
                      _fabulous();
                    },
                    icon: const Icon(Icons.thumb_up),
                    color: Colors.red,
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(right: 36),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {
                      _fabulous();
                    },
                    icon: const Icon(Icons.thumb_up),
                    color: Colors.blue,
                  ),
                ),
          widget.is_love
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {
                      _delCollection();
                    },
                    icon: const Icon(Icons.favorite),
                    color: Colors.red,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {
                      _collection();
                    },
                    icon: const Icon(Icons.favorite),
                    color: Colors.blue,
                  ),
                ),
        ],
      ),
      const SizedBox(height: 36)
    ]);
  }
}
