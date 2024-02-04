/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-04 15:52:35
 * @LastEditors: 18855190718 1491579574@qq.com
 * @LastEditTime: 2023-09-16 20:09:52
 * @FilePath: \study_bug\lib\views\public\ChatSearchPage.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// 聊天列表
// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:ltpp/assembly/ChatLine.dart';
import 'package:ltpp/assembly/MySearch.dart';
import '../../assembly/MyLoading.dart';
import '../../public/Global.dart';
import '../../public/Http.dart';
import 'package:ltpp/assembly/MyEmpty.dart';

// ignore: must_be_immutable
class ChatSearchPage extends StatefulWidget {
  String search_key;
  ChatSearchPage({super.key, required this.search_key});
  @override
  // ignore: library_private_types_in_public_api
  _ChatSearchState createState() => _ChatSearchState();
}

class _ChatSearchState extends State<ChatSearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  // ignore: prefer_final_fields
  ScrollController _scrollController = ScrollController();
  List data = [];
  // ignore: non_constant_identifier_names
  bool _get_data = false;

  @override
  void initState() {
    super.initState();
    search();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // ignore: no_leading_underscores_for_local_identifiers, non_constant_identifier_names
    List<Widget> _view_list = [
      Padding(
          padding: const EdgeInsets.all(10),
          child: MySearch(new_page_name: 'ChatSearchPage'))
    ];
    if (!_get_data) {
      return const MyLoading();
    }

    for (int i = 0; i < data.length; ++i) {
      _view_list.add(GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            clearNolookNum(i);
            Global.toChatPage(context, data[i]);
          },
          child: ChatLine(
            title: (data[i]['name'] ?? '') +
                ((data[i]['type'] ?? '') == 'group_chat' ? '（群聊）' : ''),
            online: (data[i]['online'] ?? 0) == 1,
            headimage: data[i]['headimage'] ?? '',
            // ignore: prefer_interpolation_to_compose_strings
            tips: (data[i]['no_look_num'] ?? 0) != 0
                // ignore: prefer_interpolation_to_compose_strings
                ? (data[i]['no_look_num'] ?? 0).toString() + '条未读消息'
                : '',
          )));
    }

    return Scaffold(
        appBar: AppBar(
            title: const Text(
              '聊天',
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
          ),
        ));
  }

  void search() async {
    String key = widget.search_key;
    if (!mounted) {
      return;
    }
    setState(() {
      _get_data = false;
    });
    Map<String, dynamic> res = await Http.sendPost('/Chat/ChatFindUser',
        context: context, body: {'Key': key});

    if (res['code'] == 1) {
      setState(() {
        data = res['data'];
        _get_data = true;
      });
    } else {
      setState(() {
        _get_data = true;
      });
    }
  }

  void clearNolookNum(int loc) async {
    if (!mounted) {
      return;
    }
    await Http.sendPost('/Chat/clearNolookNum', context: context, body: {
      'user_id': (data[loc]['id'] ?? ''),
      'type': (data[loc]['type'] ?? '')
    });
    setState(() {
      data[loc]['no_look_num'] = 0;
    });
  }
}
