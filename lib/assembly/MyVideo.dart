/*
 * @Author: 18855190718 1491579574@qq.com
 * @Date: 2023-03-09 16:00:12
 * @LastEditors: SQS 1491579574@qq.com
 * @LastEditTime: 2023-05-28 13:00:21
 * @FilePath: \study_bug\lib\assembly\MyVideo.dart
 * @Description: Email:1491579574@qq.com
 * QQ:1491579574
 * Copyright (c) 2023 by ${git_name_email}, All Rights Reserved. 
 */

import 'package:flutter/material.dart';

import 'package:chewie/chewie.dart';
import 'package:ltpp/public/Global.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class MyVideo extends StatefulWidget {
  Map vide_data = {};
  // ignore: use_key_in_widget_constructors, type_init_formals
  MyVideo(Map this.vide_data, {Key? key});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _MyVideoState createState() => _MyVideoState();
}

class _MyVideoState extends State<MyVideo> {
  // 生成控制器(两个)
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  bool loadfinish = false;
  bool _isPlaying = false;
  Map _vide_data = {};

  @override
  void initState() {
    if (!mounted) {
      return;
    }
    super.initState();
    _vide_data = widget.vide_data;
    videoPlayerController =
        VideoPlayerController.network(_vide_data['url'] ?? '');
    // 获取到视频初始化后回调初始化播放器
    videoPlayerController.initialize().then((_) {
      setState(() {
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          allowPlaybackSpeedChanging: false,
          allowFullScreen: false,
          allowedScreenSleep: false,
          zoomAndPan: false,
          aspectRatio: videoPlayerController.value.aspectRatio,
          // 自动播放
          autoPlay: Global.video_is_begin,
          // 循环
          looping: true,
          showControls: false,
          overlay: const SizedBox.shrink(),
          autoInitialize: true,
        );
        loadfinish = true;
      });
    });
    videoPlayerController.addListener(() {
      if (videoPlayerController.value.isPlaying) {
        setState(() {
          _isPlaying = true;
        });
      } else {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    if (!mounted) {
      return;
    }
    // 销毁播放器的控制器
    try {
      videoPlayerController.dispose();
      chewieController.dispose();
      // ignore: empty_catches
    } catch (err) {}
    super.dispose();
  }

  @override
  void deactivate() {
    if (!mounted) {
      return;
    }
    try {
      videoPlayerController.dispose();
      chewieController.dispose();
      // ignore: empty_catches
    } catch (err) {}
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    if (!loadfinish) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            if (!Global.video_is_begin) {
              Global.video_is_begin = true;
            }
            _isPlaying = !_isPlaying;
            if (_isPlaying) {
              videoPlayerController.play();
            } else {
              videoPlayerController.pause();
            }
          });
        },
        child: Chewie(controller: chewieController),
      ),
    );
  }
}
