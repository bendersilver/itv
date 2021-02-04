import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itv/models/Playlist.dart';
import 'package:itv/models/PlaylistItem.dart';
import 'package:itv/models/XmlTv.dart';
import 'package:itv/models/helper.dart';
import 'package:itv/objectbox.g.dart';

class ProgressWidget extends StatefulWidget {
  ProgressWidget({Key key, this.id, this.showTitle}) : super(key: key);

  final int id;
  final bool showTitle;

  @override
  _ProgressWidget createState() => _ProgressWidget();
}

class _ProgressWidget extends State<ProgressWidget> {
  Timer _timer;
  XmlTvItem _item;
  int _curr;
  double _progress;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _update();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      await _update();
      setState(() => _update());
    });
    super.initState();
  }

  _update() {
    _curr = Playlist.cls.currTime;
    _item = Playlist.cls.getXmlTvByChID(widget.id);
    if (_item != null)
      _progress = (_curr - _item.start) / (_item.stop - _item.start);
  }

  @override
  Widget build(BuildContext context) {
    if (_item == null) return SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        _item.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      LinearProgressIndicator(
        minHeight: 3,
        value: _item.stop < Playlist.cls.currTime ? null : _progress,
      ),
    ]);
  }
}
