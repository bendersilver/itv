import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itv/models/PlaylistItem.dart';
import 'package:itv/models/helper.dart';
import 'package:itv/widget/Progress.dart';

class PlaylistItemWidget extends StatefulWidget {
  PlaylistItemWidget({Key key, this.item, this.onTap}) : super(key: key);

  final PlaylistItem item;
  final Function onTap;

  @override
  _PlaylistItemWidget createState() => _PlaylistItemWidget();
}

class _PlaylistItemWidget extends State<PlaylistItemWidget> {
  PlaylistItem item;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item.hide | widget.item.del) return SizedBox.shrink();
    return ListTile(
      onTap: () {
        if (widget.onTap == null) {
          // Navigator.pushNamed(context, M3UPlayer.routeName,
          //     arguments: {"ch": widget.item});
        } else {
          widget.onTap.call();
        }
      },
      onLongPress: () {
        print("onLongPress");
        // await showDialogAction(context: context, ch: widget.item);
        // setState(() {});
      },
      leading: SizedBox(
        height: 64.0,
        width: 64.0,
        child: Image.network(widget.item.logo),
      ),
      title: Text(
        widget.item.name,
        style: TextStyle(
          color: widget.item.hide ? Colors.grey : null,
          fontWeight: FontWeight.w600,
          decoration: widget.item.hide ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: ProgressWidget(id: widget.item.channelID),
    );
  }
}
