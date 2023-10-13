/*
 * @Author: SQS 1491579574@qq.com
 * @Date: 2023-05-19 14:01:51
 * @LastEditors: 18855190718 1491579574@qq.com
 * @LastEditTime: 2023-09-16 21:44:11
 * @FilePath: \study_bug\lib\assembly\MyVideoFabulousAndCollectionButton.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// ignore: file_names
// 文章点赞收藏按钮
import 'package:flutter/material.dart';
import 'package:ltpp/public/Global.dart';
import 'package:ltpp/public/Http.dart';

// ignore: must_be_immutable
class MyVideoFabulousAndCollectionButton extends StatefulWidget {
  String id = '';
  MyVideoFabulousAndCollectionButton({super.key, required this.id});

  @override
  // ignore: library_private_types_in_public_api
  _MyVideoFabulousAndCollectionButtonState createState() =>
      _MyVideoFabulousAndCollectionButtonState();
}

class _MyVideoFabulousAndCollectionButtonState
    extends State<MyVideoFabulousAndCollectionButton> {
  bool is_love = false;
  bool is_fabulous = false;
  String id = '';
  void _delFabulous() async {
    if (!is_fabulous) {
      return _fabulous();
    }

    setState(() {
      is_fabulous = false;
    });

    await Http.sendPost(context, '/Video/deleteFabulousVideo', body: {
      'video_id': id,
    });
  }

  void _delCollection() async {
    if (!is_love) {
      return _collection();
    }

    setState(() {
      is_love = false;
    });

    await Http.sendPost(context, '/Video/deleteLoveVideo', body: {
      'video_id': id,
    });
  }

  void _collection() async {
    if (is_love) {
      return _delCollection();
    }
    setState(() {
      is_love = true;
    });

    await Http.sendPost(context, '/Video/loveVideo', body: {
      'video_id': id,
    });
  }

  void _fabulous() async {
    if (is_fabulous) {
      return _delFabulous();
    }
    setState(() {
      is_fabulous = true;
    });

    await Http.sendPost(context, '/Video/fabulousVideo', body: {
      'video_id': id,
    });
  }

  Future<void> _judgeIsFabulous() async {
    // ignore: use_build_context_synchronously
    Map<String, dynamic> res =
        await Http.sendPost(context, '/Video/judgeIsFabulous', body: {
      'video_id': id,
    });
    if (res['data'] == 1) {
      setState(() {
        is_fabulous = true;
      });
    } else {
      setState(() {
        is_fabulous = false;
      });
    }
  }

  Future<void> _judgeIsCollection() async {
    // ignore: use_build_context_synchronously
    Map<String, dynamic> res =
        await Http.sendPost(context, '/Video/judgeIsLove', body: {
      'video_id': id,
    });
    if (res['data'] == 1) {
      setState(() {
        is_love = true;
      });
    } else {
      setState(() {
        is_love = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    id = widget.id;
    _judgeIsCollection();
    _judgeIsFabulous();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          is_fabulous
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
                      _delFabulous();
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
          is_love
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
                      _delCollection();
                    },
                    icon: const Icon(Icons.favorite),
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
                      _collection();
                    },
                    icon: const Icon(Icons.favorite),
                    color: Colors.blue,
                  ),
                ),
          Container(
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
                Global.toVideoCommentPage(context, id);
              },
              icon: const Icon(Icons.comment),
              color: Colors.green,
            ),
          ),
        ],
      ),
      const SizedBox(height: 16)
    ]);
  }
}
