// ignore: file_names
import 'package:flutter/material.dart';
import 'package:ltpp/assembly/KeepAliveWrapper.dart';

// ignore: must_be_immutable
class MyCard extends StatelessWidget {
  Widget _child = const Text('');
  // ignore: prefer_final_fields
  double _height = 0;
  // ignore: prefer_final_fields
  // ignore: non_constant_identifier_names, prefer_final_fields, unused_field
  EdgeInsets _LTRB = const EdgeInsets.fromLTRB(6, 16, 16, 6);

  bool is_no_back_color = false;

  // ignore: non_constant_identifier_names
  MyCard(
      {super.key,
      Widget? child,
      double? height,
      this.is_no_back_color = false,
      EdgeInsets? LTRB = const EdgeInsets.fromLTRB(6, 8, 6, 8)}) {
    if (child != null) {
      _child = child;
    }
    if (LTRB != null) {
      _LTRB = LTRB;
    }
    if (height != null) {
      _height = height;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: is_no_back_color
          ? Colors.transparent
          : const Color.fromARGB(135, 255, 255, 255), // 背景色
      shadowColor: Colors.black, // 阴影颜色
      elevation: 8, // 阴影高度
      margin: _LTRB, // 外边距
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: KeepAliveWrapper(
            child: SizedBox(
          height: _height,
          child: _child,
        )),
      ),
    );
  }
}
