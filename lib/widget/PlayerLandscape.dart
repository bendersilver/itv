import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:itv/models/Playlist.dart';
import 'package:itv/models/PlaylistItem.dart';
import 'package:itv/widget/helper.dart';

import 'package:video_player/video_player.dart';

class PlayerLandscape extends StatefulWidget {
  PlayerLandscape({Key key, this.ctrl, this.initPlayer, this.item})
      : super(key: key);

  final VideoPlayerController ctrl;
  final Future<void> initPlayer;
  final PlaylistItem item;

  @override
  _PlayerLandscape createState() => _PlayerLandscape();
}

class _PlayerLandscape extends State<PlayerLandscape> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.item.openNaw = false;
    _toggleNaw();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _toggleNaw() {
    _timer?.cancel();
    setState(() => widget.item.openNaw = true);
    _timer = Timer(Duration(seconds: 5), () {
      setState(() => widget.item.openNaw = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          _toggleNaw();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: 16.0 / 9.0,
                  child: FutureBuilder(
                      future: widget.initPlayer,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          widget.ctrl.play();
                          return VideoPlayer(widget.ctrl);
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                ),
              ),
              widget.item.openNaw
                  ? Align(
                      alignment: Alignment.topCenter,
                      child: ListTile(
                        title: Row(children: [
                          SizedBox(
                            height: 64.0,
                            width: 64.0,
                            child: Image.network(widget.item.logo),
                          ),
                          wsText(widget.item.name)
                        ]),
                        leading: IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        trailing: IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.close),
                          onPressed: () {
                            print(widget.item.openNaw);
                            widget.item.openNaw = false;
                            setState(() {});
                          },
                        ),
                      ),
                    )
                  : Container(),
              // PlayerLandscapeNav(item: widget.item),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerLandscapeNav extends StatefulWidget {
  PlayerLandscapeNav({Key key, this.item}) : super(key: key);

  final PlaylistItem item;

  @override
  _PlayerLandscapeNav createState() => _PlayerLandscapeNav();
}

class _PlayerLandscapeNav extends State<PlayerLandscapeNav> {
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
    return GestureDetector(
        onTap: () {},
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child:
                //  FutureBuilder(
                //     future: widget.item.openPlayerNaw,
                //     builder: (context, snapshot) {
                //       if (snapshot.data != null && snapshot.data) {
                //         return
                Container(
              color: Colors.black.withOpacity(0.5),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  widget.item.openNaw
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: ListTile(
                            title: Row(children: [
                              SizedBox(
                                height: 64.0,
                                width: 64.0,
                                child: Image.network(widget.item.logo),
                              ),
                              wsText(widget.item.name)
                            ]),
                            leading: IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            trailing: IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.close),
                              onPressed: () {
                                print(widget.item.openNaw);
                                widget.item.openNaw = false;
                                setState(() {});
                              },
                            ),
                          ),
                        )
                      : Container(),
                  // widget.item.pExists
                  //     ? Align(
                  //         alignment: Alignment.bottomCenter,
                  //         child: Padding(
                  //           padding: EdgeInsets.symmetric(horizontal: 16),
                  //           child: Container(
                  //             height: 70,
                  //             child: Column(
                  //               children: [
                  //                 wsText(widget.item.p.title),
                  //                 Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     wsText(
                  //                         DateFormat('HH:mm').format(DateTime
                  //                             .fromMillisecondsSinceEpoch(
                  //                                 widget.item.p.start *
                  //                                     1000)),
                  //                         14),
                  //                     wsText(
                  //                         DateFormat('HH:mm').format(DateTime
                  //                             .fromMillisecondsSinceEpoch(
                  //                                 widget.item.p.stop *
                  //                                     1000)),
                  //                         14),
                  //                   ],
                  //                 ),
                  //                 Progress(item: widget.item)
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     : Container(),
                ],
              ),
            )
            // }
            // return SizedBox.shrink();
            // }),
            ));
  }
}
