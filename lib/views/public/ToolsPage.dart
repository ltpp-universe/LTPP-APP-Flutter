// ignore: file_names
import 'package:flutter/material.dart';
import 'package:ltpp/assembly/KeepAliveWrapper.dart';
import 'package:ltpp/public/Global.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class ToolsPage extends StatefulWidget {
  // ignore: unused_field
  String ide_url = 'https://ide.ltpp.vip?language=';
  String qrcode_url = 'https://qrcode.ltpp.vip';
  String ide_title = '${Global.app_name}-IDE';
  String qrcode_title = 'LTPP在线开发平台-二维码生成';
  ToolsPage({
    super.key,
  });
  @override
  // ignore: library_private_types_in_public_api
  _ContestRankPageState createState() => _ContestRankPageState();
}

class _ContestRankPageState extends State<ToolsPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    list.add(const SizedBox(height: 36));
    list.add(Padding(
        padding: const EdgeInsets.all(Global.default_padding),
        child: FractionallySizedBox(
            widthFactor: 0.86,
            child: ElevatedButton(
              // ignore: sort_child_properties_last, prefer_single_quotes
              child: Text(widget.qrcode_title),
              onPressed: () => Global.toHtmlPage(
                  context, widget.qrcode_title, widget.qrcode_url, false),
            ))));
    List<Map<String, String>> language = [
      {'C': 'c'},
      {'C++': 'cpp'},
      {'Rust': 'rust'},
      {'PHP': 'php'},
      {'JavaScript': 'javascript'},
      {'TypeScript': 'typescript'},
      {'Golang': 'go'},
      {'Java': 'java'},
      {'python3': 'python'},
      {'C#': 'csharp'},
      {'Ruby': 'ruby'},
    ];
    for (int i = 0; i < language.length; ++i) {
      language[i].forEach((key, value) {
        list.add(Padding(
            padding: const EdgeInsets.all(Global.default_padding),
            child: FractionallySizedBox(
              widthFactor: 0.86,
              child: ElevatedButton(
                  // ignore: sort_child_properties_last, prefer_single_quotes
                  child: Text('${widget.ide_title}-$key'),
                  onPressed: () => WebViewWidget(
                      controller: Global.toHtmlPage(context, widget.ide_title,
                          widget.ide_url + value, false))),
            )));
      });
    }
    list.add(const SizedBox(height: 36));
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
        body:
            SafeArea(child: KeepAliveWrapper(child: ListView(children: list))));
  }
}
