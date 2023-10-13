// ignore_for_file: use_build_context_synchronously

/*
 * @Author: SQS 1491579574@qq.com
 * @Date: 2023-05-15 12:32:35
 * @LastEditors: 18855190718 1491579574@qq.com
 * @LastEditTime: 2023-09-16 22:44:52
 * @FilePath: \study_bug\lib\views\public\ResetPasswordPage.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
// 重置密码页面
// ignore: file_names
import 'package:flutter/material.dart';
import '../../public/Global.dart';
import '../../public/Http.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            '忘记密码',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: Global.app_bar_font_size),
          ),
          toolbarHeight: Global.app_bar_height,
          centerTitle: true),
      body: const SafeArea(child: Center(child: ResetPasswordPageView())),
    );
  }
}

class ResetPasswordPageView extends StatefulWidget {
  const ResetPasswordPageView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPageView> {
  // ignore: non_constant_identifier_names
  TextEditingController name_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController email_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: <Widget>[
        const SizedBox(height: 136),
        TextField(
          controller: name_controller,
          autofocus: true,
          decoration: const InputDecoration(
              labelText: '用户名',
              hintText: '用户名',
              prefixIcon: Icon(Icons.person)),
        ),
        TextField(
          controller: email_controller,
          decoration: const InputDecoration(
              labelText: '邮箱', hintText: '邮箱', prefixIcon: Icon(Icons.email)),
        ),
        Container(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    // ignore: sort_child_properties_last
                    child: const Text('注册账号'),
                    onPressed: () => Global.toRegisterPage(context)),
                TextButton(
                    // ignore: sort_child_properties_last
                    child: const Text('登录账号'),
                    onPressed: () => Global.toRegisterPage(context)),
              ],
            )),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FractionallySizedBox(
              widthFactor: 0.86,
              child: ElevatedButton(
                  // ignore: sort_child_properties_last
                  child: const Text('重置密码'),
                  onPressed: () => _resetPassword())),
        ),
      ],
    )));
  }

  _resetPassword() async {
    if (!mounted) {
      return;
    }
    Map<String, dynamic> res = await Http.sendPost(
        context, '/Verification/sendPassword',
        body: {'name': name_controller.text, 'to': email_controller.text});
    if (res['code'] == 1) {
      Global.toLoginPage(context);
    }
  }
}
