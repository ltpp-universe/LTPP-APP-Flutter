// 登录页面
// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ltpp/views/public/RegisterPage.dart';
import '../../main.dart';
import '../../public/Global.dart';
import '../../public/Http.dart';
import '../../public/Event.dart';
import '../../public/MyWebSocket.dart';
import 'ResetPasswordPage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const LoginPageView();
  }
}

class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageView> {
  // ignore: non_constant_identifier_names
  TextEditingController name_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController password_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController network_controller = TextEditingController();
  late FocusNode networkFocusNode;

  @override
  void initState() {
    super.initState();
    setState(() {
      network_controller.text = Global.back_url;
    });
    networkFocusNode = FocusNode();
    networkFocusNode.addListener(() {
      if (!networkFocusNode.hasFocus) {
        // 失焦时执行更新操作，例如更新数据或者执行网络请求等
        _changeNetwork();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '登录',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: Global.app_bar_font_size),
        ),
        toolbarHeight: Global.app_bar_height,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 136),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: name_controller,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: '用户名',
                    hintText: '用户名或邮箱',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: password_controller,
                  decoration: const InputDecoration(
                    labelText: '密码',
                    hintText: '您的登录密码',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: network_controller,
                  autofocus: true,
                  focusNode: networkFocusNode,
                  decoration: const InputDecoration(
                    labelText: '代理地址',
                    hintText: '代理地址',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: const Text('注册账号'),
                      onPressed: () => _toRegisterPage(),
                    ),
                    TextButton(
                      child: const Text('忘记密码'),
                      onPressed: () => _toResetPasswordPage(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        side: BorderSide(width: 0, color: Colors.white),
                      ),
                    ),
                    child: const Text('登录'),
                    onPressed: () => _judgeLogin(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getMyData(BuildContext context) async {
    Map<String, dynamic> res = await Http.sendPost(
      '/User/getMyData',
      context: context,
    );
    if (res['code'] == 1) {
      setState(() {
        Global.my_data = res['data'];
      });
    } else {
      // ignore: use_build_context_synchronously
      if (Navigator.of(context).canPop()) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      }
    }
  }

  _changeNetwork() {
    setState(() {
      Global.back_url = network_controller.text;
    });
  }

  _judgeLogin() async {
    if (!mounted) {
      return;
    }
    _changeNetwork();
    Map<String, dynamic> res = await Http.sendPost('/Login/judgeLogin',
        context: context,
        body: {
          'name': name_controller.text,
          'password': password_controller.text
        });
    if (res['code'] == 1 || res['code'] == 2) {
      await Global.setKey('authorization', res['authorization']);
      await Global.setKey('key', res['key']);
      MyWebSocket.init();
      eventBus.fire(Event('login'));
      // ignore: use_build_context_synchronously
      getMyData(context);
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
          builder: (context) => const MyApp(),
          fullscreenDialog: true, // 使用全屏对话框风格
        ),
        (route) => false,
      );
    }
  }

  _toRegisterPage() {
    if (!mounted) {
      return;
    }
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (context) => const RegisterPage(),
        fullscreenDialog: true, // 使用全屏对话框风格
      ),
      (route) => false,
    );
  }

  _toResetPasswordPage() {
    if (!mounted) {
      return;
    }
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (context) => const ResetPasswordPage(),
        fullscreenDialog: true, // 使用全屏对话框风格
      ),
      (route) => false,
    );
  }
}
