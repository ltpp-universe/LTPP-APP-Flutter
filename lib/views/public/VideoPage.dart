// 视频页面
// ignore: file_names
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
import 'package:flutter/material.dart';
import '../../assembly/MyDialog.dart';
import '../../assembly/MyLoading.dart';
import '../../assembly/VideoMiddleware.dart';
import '../../public/Global.dart';
import '../../public/Http.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late PageController _controller;
  Map _now_vide_data = {};
  List<Map> _list_data = [];
  bool _has_data = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!_has_data) {
      return const MyLoading();
    }
    return Scaffold(
      appBar: AppBar(
          title: Text(
            _now_vide_data['name'] ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: Global.app_bar_font_size),
          ),
          toolbarHeight: Global.app_bar_height,
          centerTitle: true),
      body: SafeArea(
          child: Center(
              child: PageView.builder(
        pageSnapping: true,
        scrollDirection: Axis.vertical,
        onPageChanged: (int loc) {
          setState(() {
            _now_vide_data = _list_data[loc];
          });
          if (loc == _list_data.length - 1) {
            _getData();
          }
        },
        itemBuilder: (BuildContext context, int loc) {
          _now_vide_data = _list_data[loc];
          return VideoMiddleware(_now_vide_data);
        },
        itemCount: _list_data.length,
        controller: _controller,
      ))),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _getData();
  }

  void _getData() async {
    if (!mounted) {
      return;
    }
    Map<String, dynamic> res =
        await Http.sendPost('/Video/appLoadVideo', context: context, body: {
      'id': _list_data.isNotEmpty
          ? _list_data[_list_data.length - 1]['id'] ?? ''
          : '',
      'do': true
    });

    if (res['code'] == 1) {
      if (res['data'].isEmpty) {
        // ignore: use_build_context_synchronously
        MyDialog(context, content: '没有更多啦');
        return;
      } else {
        if (res['data'].length > 0) {
          setState(() {
            if (_list_data.isEmpty) {
              _now_vide_data = res['data'][0];
            }
            for (int i = 0; i < res['data'].length; ++i) {
              _list_data.add(res['data'][i]);
            }
            if (!_has_data) {
              _has_data = true;
            }
          });
        }
      }
    }
  }
}
