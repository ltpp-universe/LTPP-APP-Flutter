// ignore: file_names
import 'package:flutter/material.dart';
import 'package:ltpp/assembly/KeepAliveWrapper.dart';
import 'package:ltpp/assembly/MyLoading.dart';
import 'package:ltpp/assembly/OneLineApp.dart';
import 'package:ltpp/public/Global.dart';
import 'package:ltpp/public/Http.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class ToolsPage extends StatefulWidget {
  // ignore: unused_field
  String ide_url = 'https://ide.ltpp.vip?language=';
  String qrcode_url = 'https://qrcode.ltpp.vip';
  String docs_url = 'https://docs.ltpp.vip/';
  String ide_title = '${Global.app_name}-IDE';
  String qrcode_title = 'LTPP在线开发平台-二维码生成';
  String docs_title = 'LTPP宇宙文档';
  ToolsPage({
    super.key,
  });
  @override
  // ignore: library_private_types_in_public_api
  _ContestRankPageState createState() => _ContestRankPageState();
}

class _ContestRankPageState extends State<ToolsPage> {
  List data = [];
  int limit = 50;
  int page = 1;
  bool is_lock = false;
  bool is_no_more = false;
  bool _get_data = false;
  // ignore: prefer_final_fields
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _getData();
    _scrollController.addListener(() {
      if (!is_no_more &&
          !is_lock &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
        _getData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_get_data) {
      return const MyLoading();
    }

    List<Widget> list = [];
    list.add(const SizedBox(height: 36));
    for (int i = 0; i < data.length; ++i) {
      list.add(GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => WebViewWidget(
              controller: Global.toHtmlPage(
                  context, data[i]['name'], data[i]['url'], false)),
          child: OneLineApp(
            data[i]['name'],
            data[i]['time'],
            data[i]['image'],
          )));
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
        body: SafeArea(
            child: KeepAliveWrapper(
                child:
                    ListView(controller: _scrollController, children: list))));
  }

  _getData() async {
    if (!mounted) {
      return;
    }
    if (is_no_more || is_lock) {
      return;
    }
    is_lock = true;
    Map<String, dynamic> res = await Http.sendPost('/App/loadAllAppList',
        context: context, body: {'page': page++, 'limit': limit});
    setState(() {
      _get_data = true;
    });
    if (res['code'] == 1) {
      if (res['data'].length == 0) {
        is_no_more = true;
      }
      setState(() {
        data.addAll(res['data']);
      });
      is_lock = false;
    } else {
      is_no_more = true;
    }
  }
}
