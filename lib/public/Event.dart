/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-07 10:40:25
 * @LastEditors: 18855190718 1491579574@qq.com
 * @LastEditTime: 2023-03-07 11:46:58
 * @FilePath: \study_bug\lib\public\event.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */
import 'package:event_bus/event_bus.dart';

/// 创建EventBus
EventBus eventBus = EventBus();

// 更新
class Event {
  // ignore: prefer_typing_uninitialized_variables
  var data;
  // ignore: non_constant_identifier_names
  Event(this.data);
}
