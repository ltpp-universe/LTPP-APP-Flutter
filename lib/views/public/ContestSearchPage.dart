/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-04 15:52:35
 * @LastEditors: 18855190718 1491579574@qq.com
 * @LastEditTime: 2023-09-16 20:13:30
 * @FilePath: \study_bug\lib\views\public\ContestSearchPage.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// OJ题库列表
// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:ltpp/assembly/ContestLine.dart';
import '../../assembly/MyLoading.dart';
import '../../public/Global.dart';
import '../../public/Http.dart';
import 'package:ltpp/assembly/MyEmpty.dart';

// ignore: must_be_immutable
class ContestSearchPage extends StatefulWidget {
  String search_key;
  ContestSearchPage({super.key, required this.search_key});
  @override
  // ignore: library_private_types_in_public_api
  _ContestListState createState() => _ContestListState();
}

class _ContestListState extends State<ContestSearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool first_init = true;
  bool is_no_more = false;
  int page = 1;
  int limit = 50;
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
          onTap: () => Global.toContestPage(context, data[i]['id']),
          child: ContestLine(
            title: data[i]['name'] ?? '',
            // ignore: prefer_interpolation_to_compose_strings
            time: (data[i]['begin'] ?? '') + ' - ' + (data[i]['end'] ?? ''),
            // ignore: prefer_interpolation_to_compose_strings
            content: '赛制类型：' + (data[i]['type'] ?? ''),
            join_num: data[i]['allpeople'] ?? 0,
          )));
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            '竞赛',
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
    Map<String, dynamic> res = await Http.sendPost('/Contest/searchContest',
        context: context, body: {'page': page++, 'limit': limit, 'key': key});

    if (res['code'] == 1) {
      if (res['data'].length == 0) {
        setState(() {
          is_no_more = true;
          _get_data = true;
        });
        return;
      }
      setState(() {
        data = res['data'];
        _get_data = true;
      });
    } else {
      --page;
      setState(() {
        _get_data = true;
      });
    }
  }
}
