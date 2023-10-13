/*
 * @Author: SQS 1491579574@qq.com
 * @Date: 2023-05-15 12:32:35
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-28 12:31:19
 * @FilePath: \study_bug\lib\views\back\BackPage.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-04 15:52:58
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-15 16:43:03
 * @FilePath: \study_bug\lib\views\BackPage.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-04 15:52:58
 * @LastEditors: 18855190718 1491579574@qq.com
 * @LastEditTime: 2023-03-06 18:57:31
 * @FilePath: \study_bug\lib\views\BackPage.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// 后台页面
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ltpp/assembly/MyUserData.dart';
import 'package:ltpp/public/MyWebSocket.dart';
import '../../public/Event.dart';
import '../../public/Global.dart';
import '../public/LoginPage.dart';

class BackPage extends StatefulWidget {
  const BackPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  BackPageState createState() => BackPageState();
}

class BackPageState extends State<BackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            '我的',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: Global.app_bar_font_size),
          ),
          toolbarHeight: Global.app_bar_height,
          centerTitle: true),
      body: const SafeArea(child: Center(child: BackView())),
    );
  }
}

class BackView extends StatefulWidget {
  const BackView({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _BackViewState createState() => _BackViewState();
}

class _BackViewState extends State<BackView> {
  //订阅eventbus
  // ignore: unused_field
  late StreamSubscription _event;

  String _authorization = '';
  String _key = '';
  // ignore: non_constant_identifier_names
  @override
  void initState() {
    super.initState();
    setState(() {
      _authorization = Global.authorization;
      _key = Global.key;
    });

    _event = eventBus.on<Event>().listen((Event e) {
      if (e.data == 'login') {
        setState(() {
          _authorization = Global.authorization;
          _key = Global.key;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (_authorization != null && _key != null && _authorization == '' ||
        _key == '') {
      return ElevatedButton(
          // ignore: sort_child_properties_last, prefer_single_quotes
          child: const Text("登录"),
          onPressed: () => _toLogin());
    }
    return ListView(
      children: [
        MyUserData(Global.my_data),
        Padding(
            padding: const EdgeInsets.all(Global.default_padding),
            child: FractionallySizedBox(
              widthFactor: 0.86,
              child: ElevatedButton(
                  // ignore: sort_child_properties_last, prefer_single_quotes
                  child: const Text("退出登录"),
                  onPressed: () => _toLogout()),
            ))
      ],
    );
  }

  _toLogin() {
    Future.delayed(Duration.zero, () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }

  _toLogout() async {
    await Global.clearFileData();
    MyWebSocket.close();
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
      (route) => false,
    );
  }
}
