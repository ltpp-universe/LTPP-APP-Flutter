// ignore_for_file: no_logic_in_create_state

/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-09 22:40:06
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-28 11:48:33
 * @FilePath: \study_bug\lib\views\public\ChatDialogPage.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// 聊天界面
import 'package:flutter/material.dart';
import 'package:ltpp/public/Event.dart';
import 'package:ltpp/public/Global.dart';
import 'package:ltpp/public/MyWebSocket.dart';
import '../../assembly/MyHeadimage.dart';
import '../../public/Http.dart';

// ignore: must_be_immutable
class ChatDialogPage extends StatefulWidget {
  final Map _data;
  // ignore: non_constant_identifier_names
  const ChatDialogPage(this._data, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatDialogPageState createState() => _ChatDialogPageState(_data);
}

class _ChatDialogPageState extends State<ChatDialogPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool _has_data = false;
  bool lock = false;
  bool is_top_msg = false;
  final List<Widget> _list_view = [];
  final _text_controller = TextEditingController();
  late final ScrollController _scroll_controller;
  // ignore: unused_field, prefer_final_fields
  Map _data = {};

  _ChatDialogPageState(Map data) {
    _data = data;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!_has_data) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    for (int i = 0; i < Global.chat_data[_data['id']]!.length; ++i) {
      Column user;
      bool is_left =
          Global.my_data['name'] != Global.chat_data[_data['id']]![i]['name'];
      if (is_left) {
        user = Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            TextButton(
                onPressed: () => Global.toUserPage(context,
                    Global.chat_data[_data['id']]![i]['post_user_id'] ?? ''),
                child: MyHeadimage(
                    Global.chat_data[_data['id']]![i]['headimage'] ?? '',
                    width: 36,
                    height: 36)),
            // ignore: prefer_interpolation_to_compose_strings
            Text((Global.chat_data[_data['id']]![i]['name'] ?? ''),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: Global.user_name_font_size,
                    fontWeight: FontWeight.bold)),
          ]),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(Global.chat_headimage_len,
                      0.0, Global.chat_headimage_len, 0.0),
                  child: Card(
                      color: const Color.fromARGB(255, 239, 239, 236),
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SelectableText(
                            Global.chat_data[_data['id']]![i]['msg'] ?? '',
                            style: const TextStyle(
                                fontSize: Global.app_content_font_size),
                          ))))),
        ]);
      } else {
        user = Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            // ignore: prefer_interpolation_to_compose_strings
            Text((Global.chat_data[_data['id']]![i]['name'] ?? ''),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: Global.user_name_font_size,
                    fontWeight: FontWeight.bold)),
            TextButton(
                onPressed: () => Global.toUserPage(context,
                    Global.chat_data[_data['id']]![i]['post_user_id'] ?? ''),
                child: MyHeadimage(
                    Global.chat_data[_data['id']]![i]['headimage'] ?? '',
                    width: 36,
                    height: 36))
          ]),
          const SizedBox(height: 8),
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(Global.chat_headimage_len,
                      0.0, Global.chat_headimage_len, 0.0),
                  child: Card(
                      color: const Color.fromARGB(255, 239, 239, 236),
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SelectableText(
                            Global.chat_data[_data['id']]![i]['msg'] ?? '',
                            style: const TextStyle(
                                fontSize: Global.app_content_font_size),
                          ))))),
        ]);
      }
      if (is_top_msg) {
        _list_view.insert(0, Container(child: user));
      } else {
        _list_view.add(Container(child: user));
      }
    }
    return SafeArea(
        child: Stack(children: [
      Column(children: [
        Expanded(
          child: ListView(
            controller: _scroll_controller,
            children: _list_view,
          ),
        ),
        const SizedBox(height: 66),
      ]),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Stack(children: [
              TextField(
                controller: _text_controller,
                autofocus: false,
                decoration: const InputDecoration(
                  hintText: '请输入消息',
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Color(Global.app_theme),
                    ),
                    onPressed: () {
                      send();
                    },
                  ))
            ])),
      )
    ]));
  }

  @override
  void initState() {
    super.initState();
    _scroll_controller = ScrollController();
    getMyData();
    _scroll_controller.addListener(() {
      if (_scroll_controller.position.pixels == 0 && !lock) {
        is_top_msg = true;
        _getHistoryData();
      }
    });
    eventBus.on<Event>().listen((Event e) {
      if (e.data == 'new_msg') {
        is_top_msg = false;
        try {
          setState(() {
            scroolToBottom(960);
          });
          // ignore: empty_catches
        } catch (err) {}
      }
    });
  }

  void send() async {
    if (!mounted) {
      return;
    }
    String msg = _text_controller.text;
    _text_controller.text = '';
    Map my_msg_map = {
      'msg': msg,
      'msgtype': _data['type'],
      'user_id': _data['id'],
      'user_name': _data['name'],
    };
    MyWebSocket.send(my_msg_map);
    scroolToBottom(0);
  }

  void getMyData() async {
    if (!mounted) {
      return;
    }
    Map<String, dynamic> res = await Http.sendPost(
      context,
      '/User/getMyData',
    );
    if (res['code'] == 1) {
      setState(() {
        Global.my_data = res['data'];
      });
      _getData();
    } else {
      // ignore: use_build_context_synchronously
      if (Navigator.of(context).canPop()) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      }
    }
  }

  void _getHistoryData() async {
    if (!mounted) {
      return;
    }
    lock = true;
    Map<String, dynamic> res =
        await Http.sendPost(context, '/Chat/getHistoryChatData', body: {
      'type': _data['type'],
      'msg_id': Global.chat_data.isNotEmpty
          ? Global.chat_data[_data['id']]![0]['id']
          : '',
      'user_id': _data['id']
    });
    if (res['code'] == 1) {
      setState(() {
        // 头插入不用反转
        Global.chat_data[_data['id']] = res['data'];
      });
    } else {
      // ignore: use_build_context_synchronously
      Global.backPage(context);
    }
    lock = false;
  }

  void _getData() async {
    if (!mounted) {
      return;
    }
    Map<String, dynamic> res = await Http.sendPost(
        context, '/Chat/getLatestChatData',
        body: {'type': _data['type'], 'msg_id': '', 'user_id': _data['id']});
    if (res['code'] == 1) {
      setState(() {
        Global.chat_data[_data['id']] = res['data'].reversed.toList();
        _has_data = true;
        scroolToBottom(0);
      });
    } else {
      // ignore: use_build_context_synchronously
      Global.backPage(context);
    }
  }

  void scroolToBottom(int deep) {
    if (!mounted) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (deep >= 999) {
        return;
      }
      _scroll_controller
          .animateTo(
            _scroll_controller.position.maxScrollExtent,
            duration: const Duration(milliseconds: 666),
            curve: Curves.easeIn,
          )
          .then((value) => {
                // 递归滚动，防止未滚动到底部
                if (_scroll_controller.position.pixels <
                    _scroll_controller.position.maxScrollExtent)
                  {scroolToBottom(deep + 1)}
              });
    });
  }
}
