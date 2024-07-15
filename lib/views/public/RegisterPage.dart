// 注册页面
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:ltpp/assembly/MyDialog.dart';
import '../../public/Global.dart';
import '../../public/Http.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              '注册',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: Global.app_bar_font_size),
            ),
            toolbarHeight: Global.app_bar_height,
            centerTitle: true),
        body: const SafeArea(child: RegisterPageView()));
  }
}

class RegisterPageView extends StatefulWidget {
  const RegisterPageView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPageView> {
  // ignore: non_constant_identifier_names
  TextEditingController name_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController email_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController password_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController code_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController school_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController enrollmentyear_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController subject_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController class_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  bool _is_send_code = false;
  @override
  Widget build(BuildContext context) {
    if (!_is_send_code) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
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
                    labelText: '邮箱',
                    hintText: '邮箱',
                    prefixIcon: Icon(Icons.lock)),
              ),
              Container(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          // ignore: sort_child_properties_last
                          child: const Text('登录账号'),
                          onPressed: () => Global.toLoginPage(context)),
                      TextButton(
                          // ignore: sort_child_properties_last
                          child: const Text('忘记密码'),
                          onPressed: () => Global.toResetPasswordPage(context))
                    ],
                  )),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: FractionallySizedBox(
                  widthFactor: 0.86,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          side: BorderSide(width: 0, color: Colors.white),
                        ),
                      ),
                      // ignore: sort_child_properties_last
                      child: const Text('发送验证码'),
                      onPressed: () => _sendCode()),
                ),
              ),
            ],
          )));
    }
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
            child: Column(
          children: <Widget>[
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
                  labelText: '邮箱',
                  hintText: '邮箱',
                  prefixIcon: Icon(Icons.email)),
            ),
            TextField(
              controller: password_controller,
              decoration: const InputDecoration(
                  labelText: '密码',
                  hintText: '密码',
                  prefixIcon: Icon(Icons.password)),
            ),
            TextField(
              controller: code_controller,
              decoration: const InputDecoration(
                  labelText: '验证码',
                  hintText: '验证码',
                  prefixIcon: Icon(Icons.code)),
            ),
            TextField(
              controller: school_controller,
              decoration: const InputDecoration(
                  labelText: '学校',
                  hintText: '学校',
                  prefixIcon: Icon(Icons.house)),
            ),
            TextField(
              controller: enrollmentyear_controller,
              decoration: const InputDecoration(
                  labelText: '入学年份',
                  hintText: '入学年份',
                  prefixIcon: Icon(Icons.join_full)),
            ),
            TextField(
              controller: subject_controller,
              decoration: const InputDecoration(
                  labelText: '专业',
                  hintText: '专业',
                  prefixIcon: Icon(Icons.subject)),
            ),
            TextField(
              controller: class_controller,
              decoration: const InputDecoration(
                  labelText: '班级',
                  hintText: '班级',
                  prefixIcon: Icon(Icons.class_)),
            ),
            Container(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        // ignore: sort_child_properties_last
                        child: const Text('登录'),
                        onPressed: () => Global.toLoginPage(context)),
                    TextButton(
                        // ignore: sort_child_properties_last
                        child: const Text('忘记密码'),
                        onPressed: () => Global.toResetPasswordPage(context))
                  ],
                )),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FractionallySizedBox(
                widthFactor: 0.86,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        side: BorderSide(width: 0, color: Colors.white),
                      ),
                    ),
                    // ignore: sort_child_properties_last
                    child: const Text('验证码'),
                    onPressed: () => _sendCode()),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FractionallySizedBox(
                widthFactor: 0.86,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        side: BorderSide(width: 0, color: Colors.white),
                      ),
                    ),
                    // ignore: sort_child_properties_last
                    child: const Text('注册'),
                    onPressed: () => _judgeRegister()),
              ),
            ),
          ],
        )));
  }

  _judgeRegister() async {
    if (!mounted) {
      return;
    }
    Map<String, dynamic> res =
        await Http.sendPost('/Register/judgeRegister', context: context, body: {
      'name': name_controller.text,
      'email': email_controller.text,
      'password': password_controller.text,
      'code': code_controller.text,
      'school': school_controller.text,
      'enrollmentyear': enrollmentyear_controller.text,
      'subject': subject_controller.text,
      'class': class_controller.text
    });
    if (res['code'] == 1) {
      // ignore: use_build_context_synchronously
      Global.toLoginPage(context);
    }
  }

  _sendCode() async {
    if (!mounted) {
      return;
    }
    Map<String, dynamic> res = await Http.sendPost('/Verification/send',
        context: context,
        body: {'name': name_controller.text, 'to': email_controller.text});

    if (res['code'] == 1) {
      // ignore: use_build_context_synchronously
      MyDialog(context, content: res['msg'] ?? '请求失败');
      setState(() {
        _is_send_code = true;
      });
    }
  }
}
