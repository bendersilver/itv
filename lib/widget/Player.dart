import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itv/models/PlaylistItem.dart';
import 'package:itv/widget/PlayerLandscape.dart';
import 'package:itv/widget/PlayerPortrait.dart';

import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class M3UPlayer extends StatefulWidget {
  static const String routeName = "/M3UPlayer";
  @override
  _M3UPlayerState createState() => new _M3UPlayerState();
}

class _M3UPlayerState extends State<M3UPlayer> {
  ScaffoldFeatureController _sCtrl;
  PlaylistItem _item;
  VideoPlayerController _ctrl;
  Future<void> _initPlayer;

  @override
  void initState() {
    super.initState();
    Wakelock.enable();
  }

  @override
  void dispose() {
    _sCtrl?.close();
    _ctrl.dispose();
    Wakelock.disable();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  void _update() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    setState(() {
      if (MediaQuery.of(context).orientation == Orientation.landscape) {
        SystemChrome.setEnabledSystemUIOverlays([]);
      }
      if (_item == null) {
        final Map arg = ModalRoute.of(context).settings.arguments as Map;
        _item = arg["ch"];
        _ctrl = VideoPlayerController.network(_item.url);
        _initPlayer = _ctrl.initialize();
        _ctrl.setLooping(true);
        _ctrl.setVolume(1);
        _ctrl.addListener(() {
          if (_ctrl.value.hasError) {
            _sCtrl?.close();
            final snackBar = SnackBar(
              duration: Duration(seconds: 10),
              backgroundColor: Colors.red,
              content: Text(_ctrl.value.errorDescription),
            );

            _sCtrl = ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        });
      }
    });
  }

  void _updateCtrl(PlaylistItem item) {
    if (item == _item) return;
    final oldCtrl = _ctrl;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await oldCtrl.dispose();
    });
    _item = item;
    _initPlayer = null;
    _ctrl = VideoPlayerController.network(_item.url);
    _initPlayer = _ctrl.initialize();
    _ctrl.setLooping(true);
    _ctrl.setVolume(1);
    _ctrl.addListener(() {
      if (_ctrl.value.hasError) {
        _sCtrl?.close();
        final snackBar = SnackBar(
          duration: Duration(seconds: 10),
          backgroundColor: Colors.red,
          content: Text(_ctrl.value.errorDescription),
        );

        _sCtrl = ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _update();
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return PlayerLandscape(
        ctrl: _ctrl,
        initPlayer: _initPlayer,
        item: _item,
      );
    }
    return PlayerPortrait(
      ctrl: _ctrl,
      initPlayer: _initPlayer,
      item: _item,
      updateCtrl: _updateCtrl,
    );
  }
}
