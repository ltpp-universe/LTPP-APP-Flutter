// ignore: file_names
import 'package:flutter/material.dart';
import 'package:ltpp/public/Global.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class IdePage extends StatefulWidget {
  // ignore: unused_field
  String url = 'https://ide.ltpp.vip';

  IdePage({
    super.key,
  });
  @override
  // ignore: library_private_types_in_public_api
  _ContestRankPageState createState() => _ContestRankPageState();
}

class _ContestRankPageState extends State<IdePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              Global.app_name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: Global.app_bar_font_size),
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
