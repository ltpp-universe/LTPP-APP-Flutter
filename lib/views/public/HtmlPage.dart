/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-06-18 16:44:56
 * @LastEditors: 18855190718 1491579574@qq.com
 * @LastEditTime: 2023-09-16 20:22:00
 * @FilePath: \study_bug\lib\views\public\HtmlPage.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by SQS, All Rights Reserved. 
 */
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:ltpp/public/Global.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class HtmlPage extends StatefulWidget {
  // ignore: unused_field
  String title = '';
  String url = '';
  HtmlPage({super.key, required this.title, required this.url});
  @override
  // ignore: library_private_types_in_public_api
  _HtmlPageState createState() => _HtmlPageState();
}

class _HtmlPageState extends State<HtmlPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: Global.app_bar_font_size),
            ),
            toolbarHeight: Global.app_bar_height,
            centerTitle: true),
        body: SafeArea(
            child: WebViewWidget(
                controller: WebViewController()
                  ..setJavaScriptMode(JavaScriptMode.unrestricted)
                  ..loadRequest(Uri.parse(widget.url)))));
  }
}
