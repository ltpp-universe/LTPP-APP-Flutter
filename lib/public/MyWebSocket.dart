/*
 * @Author: SQS 1491579574@qq.com
 * @Date: 2023-05-18 09:46:55
 * @LastEditors: 18855190718 1491579574@qq.com
 * @LastEditTime: 2023-06-18 17:58:02
 * @FilePath: \study_bug\lib\public\MyWebSocket.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
import 'dart:convert';
import 'dart:io';
import 'Event.dart';
import 'Global.dart';

class MyWebSocket {
  // ignore: non_constant_identifier_names, prefer_interpolation_to_compose_strings, constant_identifier_names
  static const String public_ws_url = 'wss://wss.ltpp.vip?';
  // ignore: constant_identifier_names
  static const String private_ws_url = 'ws://hbnuoj.ltpp.vip:47272?';
  static String ws_url = '';
  static late WebSocket? _webSocket;
  static bool success = false;
  static Future<void> connect() async {
    try {
      MyWebSocket._webSocket = await WebSocket.connect(MyWebSocket.ws_url +
          Global.authorization +
          Global.ws_connect_between_str +
          Global.key);
    } catch (e) {
      // ignore: avoid_print, prefer_interpolation_to_compose_strings
      print('连接失败：' + e.toString());
      MyWebSocket.success = false;
      await MyWebSocket.connect();
      return;
    }
    MyWebSocket.success = true;
    // ignore: prefer_interpolation_to_compose_strings, avoid_print
    print('聊天服务器连接成功' +
        (MyWebSocket.ws_url +
            Global.authorization +
            Global.ws_connect_between_str +
            Global.key));
    MyWebSocket._webSocket!.listen((data) {
      MyWebSocket.onData(data);
    }, onError: (error) async {
      // ignore: avoid_print
      print('聊天服务器出错: $error');
      await MyWebSocket.connect();
    }, onDone: () async {
      // ignore: avoid_print
      print('聊天服务器连接断开');
      await MyWebSocket.connect();
    }, cancelOnError: true);
  }

  static Future<void> init() async {
    MyWebSocket.ws_url = Global.public_network
        ? MyWebSocket.public_ws_url
        : MyWebSocket.private_ws_url;
    try {
      await MyWebSocket.connect();
      // ignore: avoid_print, prefer_interpolation_to_compose_strings
      Map my_msg_map = {
        'msgtype': 'connect_group',
        'group_data': {},
      };
      MyWebSocket.send(my_msg_map);
    } catch (e) {
      // ignore: avoid_print, prefer_interpolation_to_compose_strings
      print('连接出错，重连中：' + e.toString());
      await MyWebSocket.connect();
    }
  }

  static Future<void> send(Map message) async {
    if (MyWebSocket._webSocket != null &&
        MyWebSocket._webSocket!.readyState == WebSocket.open) {
      MyWebSocket._webSocket!.add(jsonEncode(message));
      // ignore: avoid_print
      print('消息发送成功');
    } else {
      MyWebSocket.connect();
    }
  }

  static Future<void> close() async {
    if (MyWebSocket._webSocket != null) {
      await MyWebSocket._webSocket!.close();
      MyWebSocket._webSocket = null;
    }
  }

  static void onData(String data) {
    // ignore: avoid_print, prefer_interpolation_to_compose_strings
    print('聊天服务器新消息：' + data);
    Map msg_map = jsonDecode(data);
    if (!msg_map.containsKey('type') || msg_map['type'] == 'ping') {
      return;
    }
    bool has = false;
    if (msg_map['type'] == 'private_chat' || msg_map['type'] == 'group_chat') {
      for (var tem in Global.chat_list) {
        if (tem['id'] == msg_map['post_user_id']) {
          has = true;
          break;
        }
      }
      if (!has) {
        Global.chat_list.add({
          'id': msg_map['post_user_id'],
          'headimage': msg_map['headimage'],
          'name': msg_map['name'],
          'type': msg_map['type'],
          'online': 1,
          'no_look_num': 1
        });
      }
    }
    if (Global.now_chat_user_id != msg_map['post_user_id']) {
      for (var tem in Global.chat_list) {
        if (tem['id'] == msg_map['post_user_id']) {
          if (tem['no_look_num'] is String) {
            tem['no_look_num'] = int.parse(tem['no_look_num']) + 1;
          } else {
            ++tem['no_look_num'];
          }
          break;
        }
      }
      eventBus.fire(Event('new_chat_user'));
    }
    if (msg_map['post_user_id'] != null) {
      Global.chat_data[msg_map['post_user_id']] = [msg_map];
      eventBus.fire(Event('new_msg'));
    }
  }
}
