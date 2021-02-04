import 'package:itv/models/helper.dart';
import 'package:objectbox/objectbox.dart';
import 'package:m3u/m3u.dart';

@Entity()
class PlaylistItemGroup {
  int id;
  int channelID;
  String name;

  PlaylistItemGroup({this.channelID, this.name});
}

@Entity()
class PlaylistItem {
  int id;
  int channelID;
  String name;
  String url;
  String logo;
  bool hide;
  bool del;
  int order;

  @Transient()
  bool menuOpen;

  PlaylistItem({
    this.channelID,
    this.name,
    this.url,
    this.logo,
    this.hide,
    this.del,
    this.order,
  });

  factory PlaylistItem.fromEntry(M3uGenericEntry e, int order) =>
      new PlaylistItem(
        channelID: int.tryParse(e.attributes["tvg-id"]),
        name: e.title,
        url: e.link,
        logo: e.attributes["tvg-logo"],
        hide: false,
        del: false,
        order: order,
      );
}
