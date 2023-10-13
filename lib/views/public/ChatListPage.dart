/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-04 15:52:35
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-26 17:28:08
 * @FilePath: \study_bug\lib\views\public\ChatListPage.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// 聊天列表
// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:ltpp/assembly/ChatLine.dart';
import 'package:ltpp/assembly/MySearch.dart';
import 'package:ltpp/public/Event.dart';
import '../../assembly/MyLoading.dart';
import '../../public/Global.dart';
import '../../public/Http.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  // ignore: prefer_final_fields
  ScrollController _scrollController = ScrollController();

  // ignore: non_constant_identifier_names
  bool _get_data = false;
  _getData() async {
    if (!mounted) {
      return;
    }
    Map<String, dynamic> res = await Http.sendPost(
      context,
      '/Chat/getUserAndGroupList',
    );
    if (res['code'] == 1) {
      setState(() {
        Global.chat_list.addAll(res['data']);
        _get_data = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
    eventBus.on<Event>().listen((Event e) {
      if (e.data == 'new_chat_user') {
        try {
          setState(() {});
          // ignore: empty_catches
        } catch (err) {}
      }
    });
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
    _view_list.add(
      const SizedBox(height: 8),
    );
    for (int i = 0; i < Global.chat_list.length; ++i) {
      _view_list.add(GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            clearNolookNum(i);
            Global.toChatPage(context, Global.chat_list[i]);
          },
          child: ChatLine(
            title: (Global.chat_list[i]['name'] ?? '') +
                ((Global.chat_list[i]['type'] ?? '') == 'group_chat'
                    ? '（群聊）'
                    : ''),
            online: (Global.chat_list[i]['online'] ?? 0) == 1,
            headimage: Global.chat_list[i]['headimage'] ?? '',
            // ignore: prefer_interpolation_to_compose_strings
            tips: (Global.chat_list[i]['no_look_num'] ?? 0) != 0
                // ignore: prefer_interpolation_to_compose_strings
                ? (Global.chat_list[i]['no_look_num'] ?? 0).toString() + '条未读消息'
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
            children: _view_list,
          ),
        ));
  }

  void clearNolookNum(int loc) async {
    if (!mounted) {
      return;
    }
    await Http.sendPost(context, '/Chat/clearNolookNum', body: {
      'user_id': (Global.chat_list[loc]['id'] ?? ''),
      'type': (Global.chat_list[loc]['type'] ?? '')
    });
    setState(() {
      Global.chat_list[loc]['no_look_num'] = 0;
    });
  }
}
