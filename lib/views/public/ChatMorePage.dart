/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-09 22:40:06
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-25 21:43:01
 * @FilePath: \study_bug\lib\views\public\ChatMorePage.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
import 'package:flutter/material.dart';
import 'package:ltpp/assembly/MyHeadimage.dart';
import 'package:ltpp/assembly/MyUserData.dart';
import 'package:ltpp/public/Global.dart';
import 'package:ltpp/public/Http.dart';

// ignore: must_be_immutable
class ChatMorePage extends StatefulWidget {
  // ignore: prefer_final_fields
  final Map data;
  const ChatMorePage(this.data, {super.key});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _ChatMorePageState createState() => _ChatMorePageState();
}

class _ChatMorePageState extends State<ChatMorePage> {
  final List<Widget> _group_user_view_list = [];
  List<dynamic> _group_user_list = [];
  Map _user_data = {};
  bool _has_data = false;

  @override
  Widget build(BuildContext context) {
    if (!_has_data) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (widget.data['type'] == 'group_chat') {
      // 群聊
      for (var tem in _group_user_list) {
        _group_user_view_list
            .add(Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          TextButton.icon(
            onPressed: () => Global.toUserPage(context, tem['id']),
            // ignore: prefer_interpolation_to_compose_strings
            icon: MyHeadimage(tem['headimage'],
                width: Global.app_bar_height, height: Global.app_bar_height),
            // ignore: prefer_interpolation_to_compose_strings
            label: Text(tem['name'] + (tem['grade'] == 2 ? '（群主）' : ''),
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none)),
          )
        ]));
        _group_user_view_list.add(
          Divider(thickness: 1, color: Colors.grey[300]),
        );
      }
      return SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: ListView(children: _group_user_view_list)));
    } else {
      // 私聊
      return SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(8), child: MyUserData(_user_data)));
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.data['type'] == 'group_chat') {
      // 群聊
      getGroupUserList();
    } else {
      // 私聊
      _getUserData();
    }
  }

  //获取群成员列表
  void getGroupUserList() async {
    if (!mounted) {
      return;
    }
    // ignore: non_constant_identifier_names, prefer_is_empty
    Map<String, dynamic> res = await Http.sendPost(
        context, '/Chat/getGroupUserList',
        body: {'group_id': widget.data['group_data']['id']});
    if (res['code'] == 1) {
      setState(() {
        _group_user_list = res['data'];
        _has_data = true;
      });
    }
  }

  // 获取用户信息
  void _getUserData() async {
    if (!mounted) {
      return;
    }
    Map<String, dynamic> res = await Http.sendPost(
        context, '/User/lookUserData',
        body: {'user_id': widget.data['id']});
    if (res['code'] == 1) {
      setState(() {
        _user_data = res['data'];
        _has_data = true;
      });
    }
  }
}
