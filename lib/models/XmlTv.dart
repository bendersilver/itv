import 'package:itv/models/helper.dart';
import 'package:objectbox/objectbox.dart';
import 'package:xml/xml.dart';

@Entity()
class XmlTvItem {
  int id;
  int channelID;
  int start;
  int stop;
  String title;
  String desc;
  String icon;

  XmlTvItem(
      {this.channelID,
      this.start,
      this.stop,
      this.title,
      this.desc,
      this.icon});

  factory XmlTvItem.fromXmlNode(XmlNode node) => new XmlTvItem(
        channelID: int.tryParse(node.getAttribute("channel")),
        start: getTimestampXmlTv(node.getAttribute("start")),
        stop: getTimestampXmlTv(node.getAttribute("stop")),
        title: node.getElement('title').text,
        desc: node.getElement('desc')?.text,
        icon: node.getElement('icon')?.getAttribute("src"),
      );
}
