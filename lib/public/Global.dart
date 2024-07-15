/*
 * @Author: SQS 1491579574@qq.com
 * @Date: 2023-05-15 12:32:35
 * @LastEditors: 18855190718 1491579574@qq.com
 * @LastEditTime: 2023-09-16 19:39:07
 * @FilePath: \study_bug\lib\public\Global.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// ignore: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ltpp/assembly/MyDialog.dart';
import 'package:ltpp/public/Http.dart';
import 'package:ltpp/public/MyWebSocket.dart';
import 'package:ltpp/views/public/ArticleCommentPage.dart';
import 'package:ltpp/views/public/ArticlePage.dart';
import 'package:ltpp/views/public/ChatPage.dart';
import 'package:ltpp/views/public/ContestPage.dart';
import 'package:ltpp/views/public/HtmlPage.dart';
import 'package:ltpp/views/public/LoginPage.dart';
import 'package:ltpp/views/public/RegisterPage.dart';
import 'package:ltpp/views/public/ResetPasswordPage.dart';
import 'package:ltpp/views/public/VideoCommentPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:math';
import '../views/public/OjPage.dart';
import '../views/public/UserPage.dart';

class Global {
  // ignore: constant_identifier_names
  static const String app_name = 'LTPP在线开发平台';
  static String back_url = Http.public_root_url;
  // ignore: non_constant_identifier_names, prefer_final_fields
  static String _file_name = 'user';
  static int app_theme = 0xff6750a4;
  static String authorization = '';
  // ignore: non_constant_identifier_names
  static Map my_data = {};
  static String key = '';
  static String ws_connect_between_str = '@ltpp@';
  static late SharedPreferences prefs;
  // ignore: constant_identifier_names
  static const double app_bar_height = 36;
  // ignore: constant_identifier_names
  static const double app_bar_font_size = 18;
  // ignore: non_constant_identifier_names, unnecessary_late, constant_identifier_names
  static const double app_content_font_size = 16;
  // ignore: constant_identifier_names
  static const double title_font_size = 18;
  // ignore: constant_identifier_names
  static const double user_name_font_size = 16;
  // ignore: constant_identifier_names
  static const double chat_headimage_len = 46;

  // ignore: constant_identifier_names
  static const double comment_headimage_len = 36;

  // ignore: constant_identifier_names
  static const double main_comment_to_left = Global.comment_headimage_len + 26;

  // ignore: constant_identifier_names
  static const double default_padding = 8.0;

  // ignore: constant_identifier_names
  static const double child_comment_to_left =
      Global.comment_headimage_len * 2 + 52;

  static bool video_is_begin = false;

  static Map<String, List> chat_data = {};

  static String now_chat_user_id = '';

  static bool send_heart_init = false;

  static List<String> images = [
    'images/dbimage/1.jpg',
    'images/dbimage/2.jpg',
    'images/dbimage/3.jpg',
    'images/dbimage/4.jpg',
    'images/dbimage/5.jpg',
    'images/dbimage/6.jpg',
  ];

  static List<dynamic> charset = [];

  static Map<String, Uint8List> image_cache = {};

  static List chat_list = [];

  static backPage(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  // ignore: unused_element
  static toUserPage(BuildContext context, String id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserPage(id),
            fullscreenDialog: true,
            maintainState: true));
  }

  // ignore: unused_element
  static toVideoCommentPage(BuildContext context, String id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VideoCommentPage(id),
            fullscreenDialog: true,
            maintainState: true));
  }

  // ignore: unused_element
  static toArticleCommentPage(BuildContext context, String id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ArticleCommentPage(id),
            fullscreenDialog: true,
            maintainState: true));
  }

  static toProblemPage(BuildContext context, String id, {String? contest_id}) {
    if (contest_id != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OjPage(id, contest_id: contest_id),
              fullscreenDialog: true,
              maintainState: true));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OjPage(id),
              fullscreenDialog: true,
              maintainState: true));
    }
  }

  static toHtmlPage(
      BuildContext context, String title, String url, bool is_copy) {
    // ignore: unrelated_type_equality_checks
    if (is_copy == true) {
      Global.copy(url);
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HtmlPage(title: title, url: url),
            fullscreenDialog: true,
            maintainState: true));
  }

  static toArticlePage(BuildContext context, String id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ArticlePage(id),
            fullscreenDialog: true,
            maintainState: true));
  }

  static toChatPage(BuildContext context, Map data) {
    Global.now_chat_user_id = data['id'];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatPage(data),
            fullscreenDialog: true,
            maintainState: true));
  }

  static toContestPage(BuildContext context, String id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ContestPage(id),
            fullscreenDialog: true,
            maintainState: true));
  }

  static toResetPasswordPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => const ResetPasswordPage(),
          fullscreenDialog: true,
          maintainState: true),
      (route) => false,
    );
  }

  static toRegisterPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => const RegisterPage(),
          fullscreenDialog: true,
          maintainState: true),
      (route) => false,
    );
  }

  // ignore: unused_element
  static toLoginPage(
    BuildContext context,
  ) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => const LoginPage(),
          fullscreenDialog: true,
          maintainState: true),
      (route) => false,
    );
  }

  static void copy(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  static Future<void> getCharset() async {
    Map<String, dynamic> res = await Http.sendPost('/Cloudfile/loadCharset');
    Global.charset = res['data'];
  }

  static Future<String> base64Encode(String str) async {
    if (Global.charset.isEmpty) {
      return '';
    }

    str = str.toString();
    int len = str.length;
    String bin = '';
    for (int i = 0; i < len; ++i) {
      bin += str[i].codeUnitAt(0).toRadixString(2).padLeft(24, '0');
    }

    len = bin.length;
    String base64_encode = '';
    for (int i = 0; i < len; i += 6) {
      String tem_bin = '';
      for (int j = i; j - i < 6 && j < len; ++j) {
        tem_bin += bin[j];
      }
      base64_encode += Global.charset[int.parse(tem_bin, radix: 2)] as String;
    }
    return base64_encode;
  }

  static Future init() async {
    await Global.getCharset();
    prefs = await SharedPreferences.getInstance();
    Map data = await getFileData();
    Global.authorization = data['authorization'] ?? '';
    setKey('authorization', authorization);
    Global.key = data['key'] ?? '';
    setKey('key', key);
    await Global.loadAssets();
    if (Global.authorization != '' && Global.key != '') {
      MyWebSocket.init();
    }
  }

  static void onlineHeart(BuildContext context) {
    Http.sendPost(
      '/User/sendHeart',
      context: context,
    );
  }

  // 将图片读入内存
  static Future<void> loadAssets() async {
    final AssetBundle bundle = rootBundle;
    for (final String asset_name in images) {
      final ByteData data = await bundle.load(asset_name);
      final Uint8List bytes = data.buffer.asUint8List();
      Global.image_cache[asset_name] = bytes;
    }
  }

  // ignore: non_constant_identifier_names
  static setKey(String save_key, String save_value) async {
    if (save_key == 'authorization') {
      Global.authorization = save_value;
    } else if (save_key == 'key') {
      Global.key = save_value;
    }
    await prefs.setString(Global.key, save_value);
    creatFile(jsonEncode({
      'authorization': Global.authorization,
      'key': key,
    }));
  }

  // ignore: non_constant_identifier_names
  static getKey(String get_key) {
    return prefs.getString(get_key);
  }

  static creatFile(String fileStr) async {
    // 获取应用文档目录并创建文件
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    File file = File('$documentsPath/$_file_name');
    if (!file.existsSync()) {
      file.createSync();
    }
    await writeToFile(file, fileStr);
  }

  //将数据内容写入指定文件中
  static writeToFile(File file, String fileStr) async {
    await file.writeAsString(fileStr);
  }

  static Future<Map> getFileData() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    File file = File('$documentsPath/$_file_name');
    if (!file.existsSync()) {
      // ignore: unnecessary_string_interpolations
      creatFile('');
      return {};
    }
    String fileStr = await file.readAsString();
    try {
      // ignore: unused_local_variable
      Map res = jsonDecode(fileStr) as Map;
      return res;
    } catch (e) {
      return {};
    }
  }

  static clearFileData() async {
    Global.authorization = '';
    Global.key = '';
    await prefs.setString('authorization', '');
    await prefs.setString('key', '');
    creatFile('');
  }

  static Uint8List? getOneImage() {
    int len = Global.images.length;
    int loc = Global.getRandom(0, len - 1);
    String asset_name = Global.images[loc];
    return Global.image_cache[asset_name];
  }

  static getRandom(int min, int max) {
    Random random = Random();
    return random.nextInt(max) + min;
  }
}
