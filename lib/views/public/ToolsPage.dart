// ignore: file_names
import 'package:flutter/material.dart';
import 'package:ltpp/public/Global.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class ToolsPage extends StatefulWidget {
  // ignore: unused_field
  String ide_url = 'https://ide.ltpp.vip';
  String qrcode_url = 'https://qrcode.ltpp.vip';
  String ide_title = 'LTPP在线开发平台-IDE';
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
            child: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.all(Global.default_padding),
                child: FractionallySizedBox(
                  widthFactor: 0.86,
                  child: ElevatedButton(
                      // ignore: sort_child_properties_last, prefer_single_quotes
                      child: Text(widget.ide_title),
                      onPressed: () => WebViewWidget(
                          controller: Global.toHtmlPage(context,
                              widget.ide_title, widget.ide_url, false))),
                )),
            Padding(
                padding: const EdgeInsets.all(Global.default_padding),
                child: FractionallySizedBox(
                    widthFactor: 0.86,
                    child: ElevatedButton(
                      // ignore: sort_child_properties_last, prefer_single_quotes
                      child: Text(widget.qrcode_title),
                      onPressed: () => Global.toHtmlPage(context,
                          widget.qrcode_title, widget.qrcode_url, false),
                    )))
          ],
        )));
  }
}
