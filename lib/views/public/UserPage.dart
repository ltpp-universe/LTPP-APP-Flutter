// ignore_for_file: no_logic_in_create_state

/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 1623-03-06 17:55:37
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-19 13:35:43
 * @FilePath: \study_bug\lib\views\public\UserPage.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 1623 by ${git_name_email}, All Rights Reserved. 
 */
// 用户详情页面
// ignore: file_names

import 'package:flutter/material.dart';
import 'package:ltpp/assembly/MyUserData.dart';
import '../../assembly/MyHeadimage.dart';
import '../../assembly/MyLoading.dart';
import '../../public/Global.dart';
import '../../public/Http.dart';

// ignore: must_be_immutable
class UserPage extends StatefulWidget {
  // ignore: unused_field
  String _id = '';
  UserPage(String id, {super.key}) {
    _id = id;
  }

  @override
  // ignore: library_private_types_in_public_api
  _UserPageState createState() => _UserPageState(_id);
}

class _UserPageState extends State<UserPage> {
  // ignore: prefer_final_fields
  Map _data = {};
  // ignore: non_constant_identifier_names
  bool _has_data = false;
  _UserPageState(String id) {
    _data['id'] = id;
  }

  @override
  Widget build(BuildContext context) {
    if (!_has_data) {
      return const MyLoading();
    }

    return Scaffold(
        appBar: AppBar(
            title: Row(children: <Widget>[
              MyHeadimage(_data['headimage'] ?? '',
                  width: Global.app_bar_height * 0.8,
                  height: Global.app_bar_height * 0.8),
              // ignore: prefer_interpolation_to_compose_strings
              Text(
                // ignore: prefer_interpolation_to_compose_strings
                '  ' + _data['name'] + '的主页  ',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: Global.app_bar_font_size),
              )
            ]),
            toolbarHeight: Global.app_bar_height,
            centerTitle: true),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(10), child: MyUserData(_data)),
        ));
  }

  void _getData() async {
    if (!mounted) {
      return;
    }
    Map<String, dynamic> res = await Http.sendPost('/User/lookUserData',
        context: context, body: {'user_id': _data['id']});
    if (res['code'] == 1) {
      setState(() {
        _data = res['data'];
        _has_data = true;
      });
    } else {
      // ignore: use_build_context_synchronously
      Global.backPage(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }
}
