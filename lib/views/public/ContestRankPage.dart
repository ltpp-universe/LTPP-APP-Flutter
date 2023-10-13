// ignore: file_names
import 'package:flutter/material.dart';
import 'package:ltpp/public/Global.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class ContestRankPage extends StatefulWidget {
  // ignore: unused_field
  String rank_url = '';

  ContestRankPage({super.key, required this.rank_url});
  @override
  // ignore: library_private_types_in_public_api
  _ContestRankPageState createState() => _ContestRankPageState();
}

class _ContestRankPageState extends State<ContestRankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              '竞赛实时排名',
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
                  ..loadRequest(Uri.parse(widget.rank_url)))));
  }
}
