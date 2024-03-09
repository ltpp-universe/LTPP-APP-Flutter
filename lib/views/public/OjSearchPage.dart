/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-04 15:52:35
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-25 12:14:52
 * @FilePath: \study_bug\lib\views\public\OjSearchPage.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// OJ题库列表
// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:ltpp/assembly/OjLine.dart';
import '../../assembly/MyLoading.dart';
import '../../public/Global.dart';
import '../../public/Http.dart';
import 'package:ltpp/assembly/MyEmpty.dart';

// ignore: must_be_immutable
class OjSearchPage extends StatefulWidget {
  String search_key;
  OjSearchPage({super.key, required this.search_key});
  @override
  // ignore: library_private_types_in_public_api
  _OjListState createState() => _OjListState();
}

class _OjListState extends State<OjSearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool is_no_more = false;
  int page = 1;
  int limit = 50;
  // 首次加载显示动画
  bool first_init = true;
  // ignore: prefer_final_fields
  ScrollController _scrollController = ScrollController();
  List data = [];
  // ignore: non_constant_identifier_names
  bool _get_data = false;
  // ignore: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, prefer_final_fields
  List<Widget> _view_list = [];
  bool is_lock = false;
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
          onTap: () => Global.toProblemPage(context, data[i]['id']),
          child: OjLine(
            title: data[i]['problemName'] ?? '',
            content: data[i]['problemLabe'] ?? '',
            tips: data[i]['problemFrom'] ?? '',
          )));
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            '题库',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: Global.app_bar_font_size),
          ),
          toolbarHeight: Global.app_bar_height,
          centerTitle: true),
      body: SafeArea(
          child: ListView(
        controller: _scrollController,
        children: data.isEmpty ? [MyEmpty()] : _view_list,
      )),
    );
  }

  void search() async {
    String key = widget.search_key;
    if (!mounted) {
      return;
    }
    is_no_more = false;
    if (first_init) {
      first_init = false;
      setState(() {
        _get_data = false;
      });
    }
    if (is_no_more || is_lock) {
      return;
    }
    is_lock = true;
    // ignore: non_constant_identifier_names, prefer_is_empty
    Map<String, dynamic> res = await Http.sendPost('/Oj/searchProblem',
        context: context, body: {'page': page++, 'limit': limit, 'key': key});

    if (res['code'] == 1) {
      if (res['data'].length == 0) {
        setState(() {
          _get_data = true;
          is_no_more = true;
        });
        return;
      }
      setState(() {
        data = res['data'];
        _get_data = true;
      });
      is_lock = false;
    } else {
      --page;
      setState(() {
        _get_data = true;
      });
    }
  }
}
