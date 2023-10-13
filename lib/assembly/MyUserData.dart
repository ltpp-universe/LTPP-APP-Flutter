/*
 * @Author: SQS 1491579574@qq.com
 * @Date: 2023-05-18 00:23:42
 * @LastEditors: 18855190718 1491579574@qq.com
 * @LastEditTime: 2023-09-16 19:54:08
 * @FilePath: \study_bug\lib\assembly\MyUserData.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ltpp/public/Global.dart';

// ignore: must_be_immutable
class MyUserData extends StatelessWidget {
  // ignore: non_constant_identifier_names, prefer_final_fields
  Map _user_data = {};
  MyUserData(this._user_data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(Global.default_padding),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ignore: prefer_interpolation_to_compose_strings
          Text('姓名：' + (_user_data['name'] ?? '无'),
              style: const TextStyle(fontSize: 16.0)),
          const SizedBox(height: 6),
          // ignore: prefer_interpolation_to_compose_strings
          Text('学校：' + (_user_data['school'] ?? '无'),
              style: const TextStyle(fontSize: 16.0)),
          const SizedBox(height: 6),
          // ignore: prefer_interpolation_to_compose_strings
          Text('入学年份：' + (_user_data['enrollmentyear'] ?? '无'),
              style: const TextStyle(fontSize: 16.0)),
          const SizedBox(height: 6),
          // ignore: prefer_interpolation_to_compose_strings
          Text('专业：' + (_user_data['subject'] ?? '无'),
              style: const TextStyle(fontSize: 16.0)),
          const SizedBox(height: 6),
          // ignore: prefer_interpolation_to_compose_strings
          Text('状态：' + ((_user_data['online'] ?? 0) == 1 ? '在线' : '离线'),
              style: const TextStyle(fontSize: 16.0)),
          const SizedBox(height: 6),
          // ignore: prefer_interpolation_to_compose_strings
          Text('粉丝数：' + (_user_data['fans'] ?? 0).toString() + '人',
              style: const TextStyle(fontSize: 16.0)),
          const SizedBox(height: 6),
          // ignore: prefer_interpolation_to_compose_strings
          Text('注册时间：' + (_user_data['registertime'] ?? '无'),
              style: const TextStyle(fontSize: 16.0)),
          const SizedBox(height: 6),
          // ignore: prefer_interpolation_to_compose_strings
          Text('上次在线：' + (_user_data['lastlogin'] ?? '无'),
              style: const TextStyle(fontSize: 16.0)),
          const SizedBox(height: 6),
          // ignore: prefer_interpolation_to_compose_strings
          Text('性别：' + (_user_data['sex'] ?? '男').toString(),
              style: const TextStyle(fontSize: 16.0)),
          const SizedBox(height: 6),
          // ignore: prefer_interpolation_to_compose_strings
          Text('邮箱：' + (_user_data['email'] ?? '无'),
              style: const TextStyle(fontSize: 16.0)),
          const SizedBox(height: 6),
          // ignore: prefer_interpolation_to_compose_strings
          Text('关注：' + (_user_data['follow'] ?? 0).toString() + '人',
              style: const TextStyle(fontSize: 16.0)),
          const SizedBox(height: 6),
          // ignore: prefer_interpolation_to_compose_strings
          Text('个性签名：' + (_user_data['mysay'] ?? '无'),
              style: const TextStyle(fontSize: 16.0)),
          const SizedBox(height: 6),
          Global.my_data['id'] == _user_data['id']
              ?
              // ignore: prefer_interpolation_to_compose_strings
              Text('余额：' + (_user_data['money'] ?? '无'),
                  style: const TextStyle(fontSize: 16.0))
              : const SizedBox(height: 6)
        ])));
  }
}
