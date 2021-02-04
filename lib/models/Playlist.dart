import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:itv/models/XmlTv.dart';
import 'package:m3u/m3u.dart';
import 'package:xml/xml_events.dart';
import 'package:itv/models/PlaylistItem.dart';
import 'package:itv/models/helper.dart';
import 'package:itv/objectbox.g.dart';

const M3U_URL = "http://ott.tv.planeta.tc/plst.m3u?4k";
const XMLTV_URL =
    "http://ott.tv.planeta.tc/epg/program.xml?fields=desc&fields=icon";

class Settings {
  String name;
  int val;
  Settings(this.name, this.val);
}

class Playlist {
  static bool showHide = false;
  static int sortSel = 1;
  static List<Settings> sort = [
    Settings("По номеру", 1),
    Settings("По имени", 2),
    Settings("По id", 3),
  ];

  List<XmlTvItem> _xmlTV = [];
  List<PlaylistItem> items = [];
  Timer _timer;
  Store store;
  int currTime = 0;

  Playlist._();
  static final Playlist cls = Playlist._();

  Future<bool> initial() async {
    if (store == null) store = await getStore();
    if (items.isEmpty) {
      await fetchM3U();
      fetchXMLTv();
    }
    items = store.box<PlaylistItem>().getAll();
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        _updateData();
      });
    }
    return true;
  }

  _updateData() {
    currTime = (DateTime.now().millisecondsSinceEpoch / 1000).truncate();
    if (currTime % 10 == 0) {
      _setXmlTVList();
    }
  }

  _setXmlTVList() {
    final q = store
        .box<XmlTvItem>()
        .query(((XmlTvItem_.start < currTime)
                .or(XmlTvItem_.start.equals(currTime)))
            .and(XmlTvItem_.stop > currTime))
        .build();
    _xmlTV = q.find();
    q.close();
  }

  refresh() {
    _timer.cancel();
    _xmlTV = [];
    items = [];
  }

  close() {
    refresh();
    store.close();
  }

  updateItem(PlaylistItem i) {
    store.box<PlaylistItem>().put(i);
  }

  XmlTvItem getXmlTvByChID(int id) {
    for (final i in _xmlTV) {
      if (i.channelID == id) return i;
    }
    return null;
  }

  Future<void> fetchM3U() async {
    final response = await http.get(M3U_URL);
    if (response.statusCode == 200) {
      final m3u = await M3uParser.parse(response.body);
      final box = store.box<PlaylistItem>();

      List<PlaylistItem> items = box.getAll();
      items.forEach((e) => e.del = true);

      m3u.forEach((e) {
        PlaylistItem item = PlaylistItem.fromEntry(e, items.length);
        bool exists = items.any((e) {
          if (e.url != item.url) return false;
          e.name = item.name;
          e.logo = item.logo;
          e.channelID = item.channelID;
          e.del = false;
          return true;
        });
        if (!exists) items.add(item);
        return item;
      });
      box.putMany(items);
    } else {
      throw Exception("Response status code playlit: ${response.statusCode}");
    }
  }

  Future<void> fetchXMLTv() async {
    final request = await HttpClient().getUrl(Uri.parse(XMLTV_URL));
    final response = await request.close();
    if (response.statusCode == 200) {
      final box = store.box<XmlTvItem>();
      List<XmlTvItem> items = [];
      await response
          .transform(utf8.decoder)
          .toXmlEvents()
          .selectSubtreeEvents((event) => event.name == "programme")
          .toXmlNodes()
          .flatten()
          .forEach((node) {
        items.add(XmlTvItem.fromXmlNode(node));
      });
      box.removeAll();
      box.putMany(items);
      _setXmlTVList();
    } else {
      throw Exception("Response status code xmlTV: ${response.statusCode}");
    }
  }
}
