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
/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-06 18:26:40
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-25 11:25:30
 * @FilePath: \study_bug\lib\public\Global.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// ignore: file_names
import 'dart:convert';
import 'dart:ffi';
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
  static bool public_network = true;
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
    'images/dbimage/020d85e19166992402730f307c5f93f8.jpg',
    'images/dbimage/03c6cb8053414977e6c004fc22c85e24.jpg',
    'images/dbimage/04b3181038bba91e08886265a8ebaf36.jpg',
    'images/dbimage/0b36543e64edc61eca3f6dde10bc9797.jpg',
    'images/dbimage/0b84cd986ac0e803d6f91e3a61ebc260.jpg',
    'images/dbimage/0c2f516c575d6a7927c029d5ce99e026.jpg',
    'images/dbimage/0c427c2b8486b5259cd5c4cd4c7a20aa.jpg',
    'images/dbimage/0df721ac1fe58dfad9aad7369bc703f7.jpg',
    'images/dbimage/0f8573a2194e312adb389240fc0e7d0c.jpg',
    'images/dbimage/124c9fe9f8f3c138866a8d48580c6990.jpg',
    'images/dbimage/1398b787fb0d889428d118a95960343a.jpg',
    'images/dbimage/18d3925f9d1c96a618431399a31589b3.jpg',
    'images/dbimage/1b514c5dc2c32336e5da73b2fe88e90e.jpg',
    'images/dbimage/1b6ccbe73d51432bac18166f43c81772.jpg',
    'images/dbimage/246cf410dd06c0c5d427ae904d80de6b.jpg',
    'images/dbimage/24938167f834e4486b9f61823f3b2390.jpg',
    'images/dbimage/26a4f62c60333e1edf079a879e5d91ae.jpg',
    'images/dbimage/28790dcdb316d8b3755c6aab8b22a496.jpg',
    'images/dbimage/29f37af0e3313b878e07fbcd602ba909.jpg',
    'images/dbimage/2cfc04633d1d86562f517e45f0e975aa.jpg',
    'images/dbimage/373ae5f44bc6d9c6bb39212d9eb7a690.jpg',
    'images/dbimage/3851af9cfdd05996071f56a98db8cbc2.jpg',
    'images/dbimage/3995d613af0d6fae3eafce00d4105cda.jpg',
    'images/dbimage/3c510de3ba66284c072adf35d14bf228.jpg',
    'images/dbimage/3c586d9380338bb002acde0af2faec17.jpg',
    'images/dbimage/44bc27482674a4e91bfbb0be4da8a875.jpg',
    'images/dbimage/4741bd214b658e656aa7dfe4ff565709.jpg',
    'images/dbimage/4eecc8b8674505bcf425d7999dd3fd3a.jpg',
    'images/dbimage/4f381d562bbb9c97defb8ed74416586c.jpg',
    'images/dbimage/4fc47c84f3a5233881d7103e1a06acc1.jpg',
    'images/dbimage/5144e2fd54242e5c6f7269b81aa1a248.jpg',
    'images/dbimage/5af2cf61269107951710bc7337a35778.jpg',
    'images/dbimage/5b8f5b0e303ac9712822db3a1155e6fe.jpg',
    'images/dbimage/5c54059a72789df36a5a595a8e42e7c7.jpg',
    'images/dbimage/5d69b342810765da5eb3d8cf1fabbf39.jpg',
    'images/dbimage/5efaa2e066d6bb1016e4b244347780ee.jpg',
    'images/dbimage/5f013179b1e703be86ac5e15bab6f06d.jpg',
    'images/dbimage/6557563efb971f0ebce5f50929229488.jpg',
    'images/dbimage/679e022963cad7e53080f969e31ebedc.jpg',
    'images/dbimage/684e0bdfa476db78ddcbbdd02bf42025.jpg',
    'images/dbimage/6a4aba1ceaa85782bdb2559dbaf29c5b.jpg',
    'images/dbimage/6d99cb2c00153f3d26571648e7271132.jpg',
    'images/dbimage/73834d88e05419a04efd40cc265c1b18.jpg',
    'images/dbimage/78d77a93552b6c2d5b93de58fd078f29.jpg',
    'images/dbimage/7a0be1b84192a3eb6b3d96d502388022.jpg',
    'images/dbimage/7af669cc44b1c221587bb97fcf83d07e.jpg',
    'images/dbimage/7bfa46d860f138e66b9a70e3ea2e0319.jpg',
    'images/dbimage/81d657185f7281babd0d97880e94f6ae.jpg',
    'images/dbimage/82a52768535b225dcb0d67294e31d9e8.jpg',
    'images/dbimage/82aed3c8f73b896fa00d4bd36f3ea0fa.jpg',
    'images/dbimage/83a5e4bf8607314e3ba5433c1d76a086.jpg',
    'images/dbimage/8db537978c46d44ae313a0a3bc897303.jpg',
    'images/dbimage/8fb5dd7812490104ee33af2d15a01f8c.jpg',
    'images/dbimage/95a3711fdfbb742f05dccd8a8c5cac07.jpg',
    'images/dbimage/997a6f2b446c2b445048eb5a0af80cd9.jpg',
    'images/dbimage/9a0aa733f1c2fa828ae559f87c9ac222.jpg',
    'images/dbimage/9ad92fd1fbfdd8c3006cdc5f0331e536.jpg',
    'images/dbimage/9e838f8ad4780dbe38ac4f0bda262467.jpg',
    'images/dbimage/9f28f2f9b95944bfd1bcce3636518087.jpg',
    'images/dbimage/9f7c39080f31a3db51af264e82f46b4f.jpg',
    'images/dbimage/a2a7581b6b551c7c967d6fa38411fe02.jpg',
    'images/dbimage/a37e393b42885a34569e94f6af1fc8d2.jpg',
    'images/dbimage/a47fe104caa054d8fd6d2bca114da2ab.jpg',
    'images/dbimage/a797136f5b0ea9e73c7264025fd64031.jpg',
    'images/dbimage/a9127fb7ac231f199332281b9952c827.jpg',
    'images/dbimage/b35670758fc5659d8806e004aa0d0b28.jpg',
    'images/dbimage/bcb357ad2d5db69c94d3bbbd37fc0d13.jpg',
    'images/dbimage/c9347b3c4b25622a51dc66c95fe17a0c.jpg',
    'images/dbimage/c96a03c3fa2f3c358cc2447f9f29303a.jpg',
    'images/dbimage/cac129e673658dc51a0b527017b31252.jpg',
    'images/dbimage/cd9fb5a70774edc26e6201e31f0f902e.jpg',
    'images/dbimage/d08240be2098e10bf399c18fcf9e6c05.jpg',
    'images/dbimage/d4b40a8e8a15acb02bfe9ee4bac4efec.jpg',
    'images/dbimage/dbc35550bc88ab28fd930580651321c8.jpg',
    'images/dbimage/dbecc5cc5046fae0eda15c1fa28c8fd9.jpg',
    'images/dbimage/dd6cc2d7f0d5ee41fbd86cda688dc732.jpg',
    'images/dbimage/de43abfc2184fffecd0f9a8ce9527e7a.jpg',
    'images/dbimage/de68db0c4b8a3d15e330f707125764ed.jpg',
    'images/dbimage/dfe2228cf9a84b8161a9901bb2ddeb34.jpg',
    'images/dbimage/dfe993c25a0692710db7bf0f7a2df9ba.jpg',
    'images/dbimage/e1ff568f3e21ac21ab72ed29c06adce3.jpg',
    'images/dbimage/e2499b78087ffacd5f64361265a0a038.jpg',
    'images/dbimage/e405f0c8803170737dda018560c43b01.jpg',
    'images/dbimage/e561cfef490289a5d74bfc2b5c7d1c33.jpg',
    'images/dbimage/e5d4efd8a5ca53eaf0021f62727e28e0.jpg',
    'images/dbimage/e914ddcc97c3d224959a1f6ff6625a93.jpg',
    'images/dbimage/edfd2d297e8fff0a85fb6e933b5872ea.jpg',
    'images/dbimage/f3cb96442ec5101647782d7d967c5c57.jpg',
    'images/dbimage/f81d26073759f5a5f2835056d262223f.jpg'
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

  static toHtmlPage(BuildContext context, String title, String url) {
    Global.copy(url);
    MyDialog(context, content: '外链地址复制成功');
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
    Global.authorization = data['Authorization'] ?? '';
    setKey('Authorization', authorization);
    Global.key = data['Key'] ?? '';
    setKey('Key', key);
    await Global.loadAssets();
    print('图片缓存结束');
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
    if (save_key == 'Authorization') {
      Global.authorization = save_value;
    } else if (save_key == 'Key') {
      Global.key = save_value;
    }
    await prefs.setString(Global.key, save_value);
    creatFile(jsonEncode({
      'Authorization': Global.authorization,
      'Key': key,
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
    await prefs.setString('Authorization', '');
    await prefs.setString('Key', '');
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
