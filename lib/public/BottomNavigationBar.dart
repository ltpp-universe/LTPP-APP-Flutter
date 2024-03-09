/*
 * @Author: SQS 1491579574@qq.com
 * @Date: 2023-05-15 12:32:35
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-27 19:35:05
 * @FilePath: \study_bug\lib\public\BottomNavigationBar.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// 底部导航栏
import 'package:flutter/material.dart';
import 'package:ltpp/views/public/OjListPage.dart';
import '../views/public/ArticleListPage.dart';
import '../views/public/ContestListPage.dart';
import '../views/public/VideoPage.dart';
import '../views/public/ChatListPage.dart';
import '../views/back/BackPage.dart';
import '../views//public/ToolsPage.dart';

// ignore: constant_identifier_names
const List<BottomNavigationBarItem> bottom_navigation_bar_list = [
  BottomNavigationBarItem(label: '文章', icon: Icon(Icons.home)),
  BottomNavigationBarItem(label: '题库', icon: Icon(Icons.book)),
  BottomNavigationBarItem(label: '竞赛', icon: Icon(Icons.people_alt_rounded)),
  BottomNavigationBarItem(label: '工具', icon: Icon(Icons.pan_tool)),
  BottomNavigationBarItem(label: '视频', icon: Icon(Icons.video_file_rounded)),
  BottomNavigationBarItem(label: '聊天', icon: Icon(Icons.chat)),
  BottomNavigationBarItem(label: '后台', icon: Icon(Icons.account_box)),
];

Widget getView(index) {
  switch (index) {
    case 0:
      return const ArticleListPage();
    case 1:
      return const OjListPage();
    case 2:
      return const ContestListPage();
    case 3:
      return ToolsPage();
    case 4:
      return const VideoPage();
    case 5:
      return const ChatListPage();
    case 6:
      return const BackPage();
    default:
      return const ArticleListPage();
  }
}
