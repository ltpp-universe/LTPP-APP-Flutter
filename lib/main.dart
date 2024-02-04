// ignore_for_file: unnecessary_null_comparison

/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-04 12:37:13
 * @LastEditors: 18855190718 1491579574@qq.com
 * @LastEditTime: 2023-09-16 19:21:47
 * @FilePath: \study_bug\lib\main.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved.
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ltpp/public/Http.dart';
import 'package:ltpp/views/public/LoginPage.dart';
import './public/BottomNavigationBar.dart';
import './public/Name.dart';
import './public/Global.dart';
import 'dart:async' show Timer;

void main() async {
  // 关闭Flutter的系统输出
  debugPrint = (String? message, {int? wrapWidth}) {};
  WidgetsFlutterBinding.ensureInitialized();
  await Global.init();
  runApp(const MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers, non_constant_identifier_names
    bool _is_login = true;
    if (Global.authorization.length <= 7 || Global.key.length != 32) {
      _is_login = false;
    }
    return MaterialApp(
      title: app_name,
      darkTheme: ThemeData.dark(useMaterial3: true),
      navigatorKey: GlobalKey<NavigatorState>(), // 实例化Navigator
      theme: ThemeData(
        colorSchemeSeed: Color(Global.app_theme),
        useMaterial3: true,
      ),
      home: _is_login ? const MyHomePage() : const LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin {
  void getMyData() async {
    Map<String, dynamic> res = await Http.sendPost(
      '/User/getMyData',
      context: context,
    );
    if (res['code'] == 1) {
      setState(() {
        Global.my_data = res['data'];
      });
    } else {
      // ignore: use_build_context_synchronously
      if (Navigator.of(context).canPop()) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      }
    }

    if (Global.authorization != '' &&
        Global.key != '' &&
        !Global.send_heart_init) {
      Global.send_heart_init = true;
      Timer.periodic(const Duration(seconds: 60), (timer) {
        Global.onlineHeart(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    getMyData();
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: bottom_navigation_bar_list,
        activeColor: Color(Global.app_theme),
        inactiveColor: const Color.fromARGB(255, 101, 124, 201),
      ),
      tabBuilder: (BuildContext context, int index) {
        return getView(index);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
