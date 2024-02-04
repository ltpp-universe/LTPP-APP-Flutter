/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-04 15:52:35
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-25 10:48:06
 * @FilePath: \study_bug\lib\views\public\ArticleSearchPage.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// 首页
// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:ltpp/assembly/MyEmpty.dart';
import '../../assembly/MyLoading.dart';
import '../../assembly/OneLineBox.dart';
import '../../public/Global.dart';
import '../../public/Http.dart';

// ignore: must_be_immutable
class ArticleSearchPage extends StatefulWidget {
  String search_key;
  ArticleSearchPage({super.key, required this.search_key});
  @override
  // ignore: library_private_types_in_public_api
  _ArticleListState createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleSearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool is_no_more = false;
  bool first_init = true;
  bool is_lock = false;
  // ignore: prefer_final_fields
  ScrollController _scrollController = ScrollController();
  List data = [];
  // ignore: non_constant_identifier_names
  bool _get_data = false;
// ignore: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, prefer_final_fields
  List<Widget> _view_list = [];
  @override
  void initState() {
    super.initState();
    search();
    _scrollController.addListener(() {
      if (!is_no_more &&
          !is_lock &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        search();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (!_get_data) {
      return const MyLoading();
    }
    for (int i = 0; i < data.length; ++i) {
      _view_list.add(GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Global.toArticlePage(context, data[i]['id']),
          child: OneLineBox(
            data[i]['name'],
            data[i]['article'],
            img: data[i]['image'],
          )));
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            '文章',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: Global.app_bar_font_size),
          ),
          toolbarHeight: Global.app_bar_height,
          centerTitle: true),
      body: SafeArea(
          child: ListView(
        controller: _scrollController,
        children: _view_list,
      )),
    );
  }

  void search() async {
    String key = widget.search_key;
    if (!mounted) {
      return;
    }
    if (first_init) {
      first_init = false;
      setState(() {
        is_no_more = false;
        _get_data = false;
      });
    }
    if (is_no_more || is_lock) {
      return;
    }
    is_lock = true;
    // ignore: non_constant_identifier_names, prefer_is_empty
    String last_id = data.length > 0 ? data[data.length - 1]['id'] : '';
    Map<String, dynamic> res = await Http.sendPost(
        '/Article/allArticleKeySearch',
        context: context,
        body: {'article_id': last_id, 'do': 'down', 'limit': 50, 'Key': key});

    if (res['code'] == 1) {
      if (res['data'].length == 0) {
        setState(() {
          is_no_more = true;
          _get_data = true;
          _view_list.add(MyEmpty());
        });
        is_lock = false;
        return;
      }
      setState(() {
        for (var tem in res['data']) {
          tem['image'] = Global.getOneImage();
        }
        data = res['data'];
        _get_data = true;
      });
      is_lock = false;
    } else {
      setState(() {
        _get_data = true;
      });
    }
  }
}
