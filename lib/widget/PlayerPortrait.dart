import 'dart:async';

import 'package:flutter/material.dart';
import 'package:itv/models/Playlist.dart';
import 'package:itv/models/PlaylistItem.dart';
import 'package:itv/widget/PlaylistItem.dart';
import 'package:itv/widget/Progress.dart';

import 'package:video_player/video_player.dart';

class PlayerPortrait extends StatefulWidget {
  PlayerPortrait(
      {Key key, this.ctrl, this.initPlayer, this.item, this.updateCtrl})
      : super(key: key);

  final VideoPlayerController ctrl;
  final Future<void> initPlayer;
  final PlaylistItem item;
  final Function updateCtrl;

  @override
  _PlayerPortrait createState() => _PlayerPortrait();
}

class _PlayerPortrait extends State<PlayerPortrait> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (Playlist.sortSel) {
      case 1:
        Playlist.cls.items.sort((a, b) => a.order.compareTo(b.order));
        break;
      case 2:
        Playlist.cls.items.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      case 3:
        Playlist.cls.items.sort((a, b) => a.channelID.compareTo(b.channelID));
        break;
    }
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.black,
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 9 / 16,
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16.0 / 9.0,
                  child: Center(
                      child: FutureBuilder(
                          future: widget.initPlayer,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              widget.ctrl.play();
                              return VideoPlayer(widget.ctrl);
                            }
                            return CircularProgressIndicator();
                          })),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ProgressWidget(
                    id: widget.item.channelID,
                    showTitle: false,
                  ),
                )
              ],
            ),
          ),
          ListTile(
            title: Text(widget.item.name),
            // subtitle: subtitleText(widget.item.p.title),
            leading: SizedBox(
              height: 64.0,
              width: 64.0,
              child: Image.network(widget.item.logo),
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
                itemCount: Playlist.cls.items.length,
                itemBuilder: (ctx, ix) {
                  PlaylistItem item = Playlist.cls.items[ix];
                  return PlaylistItemWidget(
                    item: item,
                    onTap: () {
                      widget.updateCtrl(item);
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
