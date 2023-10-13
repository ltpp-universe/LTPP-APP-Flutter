/*
 * @Author: SQS 1491579574@qq.com
 * @Date: 2023-05-15 12:32:35
 * @LastEditors: 18855190718 1491579574@qq.com
 * @LastEditTime: 2023-09-16 20:53:40
 * @FilePath: \study_bug\lib\views\public\ChatPage.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-09 16:00:12
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-17 09:33:17
 * @FilePath: \study_bug\lib\views\ChatPage.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// 聊天中间页
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:ltpp/public/Global.dart';
import 'package:ltpp/views/public/ChatDialogPage.dart';
import 'ChatMorePage.dart';

// ignore: must_be_immutable
class ChatPage extends StatefulWidget {
  // ignore: prefer_final_fields
  Map _data;
  ChatPage(this._data, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _ChatPageState createState() => _ChatPageState(_data);
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // ignore: prefer_final_fields
  late final Map _data;
  late final List<Widget> _list_view;
  _ChatPageState(Map data) {
    _data = data;
    // ignore: non_constant_identifier_names
    _list_view = [ChatDialogPage(_data), ChatMorePage(_data)];
  }

  List tabs = ['聊天', '更多'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: _tabController,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
      ),
      body: TabBarView(
        //构建
        controller: _tabController,
        children: _list_view.map((e) {
          return Container(
            child: e,
          );
        }).toList(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void deactivate() {
    Global.now_chat_user_id = '';
    super.deactivate();
  }
}
