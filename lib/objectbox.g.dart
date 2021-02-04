// GENERATED CODE - DO NOT MODIFY BY HAND

// Currently loading model from "JSON" which always encodes with double quotes
// ignore_for_file: prefer_single_quotes

import 'dart:typed_data';

import 'package:objectbox/objectbox.dart';
import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'models/XmlTv.dart';
import 'models/PlaylistItem.dart';

ModelDefinition getObjectBoxModel() {
  final model = ModelInfo.fromMap({
    "entities": [
      {
        "id": "1:8483537412422949423",
        "lastPropertyId": "8:5905540155579902189",
        "name": "PlaylistItem",
        "properties": [
          {"id": "1:3106794123300216649", "name": "id", "type": 6, "flags": 1},
          {"id": "2:3526130314611643843", "name": "channelID", "type": 6},
          {"id": "3:2387507801058601411", "name": "name", "type": 9},
          {"id": "4:3824738832544558088", "name": "url", "type": 9},
          {"id": "5:1654349657150138221", "name": "logo", "type": 9},
          {"id": "6:9056481973112743022", "name": "hide", "type": 1},
          {"id": "7:3417398623165154624", "name": "del", "type": 1},
          {"id": "8:5905540155579902189", "name": "order", "type": 6}
        ],
        "relations": [],
        "backlinks": []
      },
      {
        "id": "2:88792320226489959",
        "lastPropertyId": "4:7274052526358201344",
        "name": "PlaylistItemGroup",
        "properties": [
          {"id": "1:6361327999891383590", "name": "id", "type": 6, "flags": 1},
          {"id": "2:5526106044590297925", "name": "channelID", "type": 6},
          {"id": "3:1732881056251660775", "name": "name", "type": 9}
        ],
        "relations": [],
        "backlinks": []
      },
      {
        "id": "3:2675274788743770252",
        "lastPropertyId": "8:1980003943301421657",
        "name": "XmlTvItem",
        "properties": [
          {"id": "1:558764780854987317", "name": "id", "type": 6, "flags": 1},
          {"id": "2:539913984268686454", "name": "channelID", "type": 6},
          {"id": "3:5324758092352982596", "name": "start", "type": 6},
          {"id": "4:3181770827266242839", "name": "stop", "type": 6},
          {"id": "5:5745401756451151513", "name": "title", "type": 9},
          {"id": "6:4419648008619971214", "name": "desc", "type": 9},
          {"id": "7:7509355127580909614", "name": "icon", "type": 9}
        ],
        "relations": [],
        "backlinks": []
      }
    ],
    "lastEntityId": "3:2675274788743770252",
    "lastIndexId": "3:9114447171988001783",
    "lastRelationId": "0:0",
    "lastSequenceId": "0:0",
    "modelVersion": 5
  }, check: false);

  final bindings = <Type, EntityDefinition>{};
  bindings[PlaylistItem] = EntityDefinition<PlaylistItem>(
      model: model.getEntityByUid(8483537412422949423),
      toOneRelations: (PlaylistItem object) => [],
      toManyRelations: (PlaylistItem object) => {},
      getId: (PlaylistItem object) => object.id,
      setId: (PlaylistItem object, int id) {
        object.id = id;
      },
      objectToFB: (PlaylistItem object, fb.Builder fbb) {
        final offsetname =
            object.name == null ? null : fbb.writeString(object.name);
        final offseturl =
            object.url == null ? null : fbb.writeString(object.url);
        final offsetlogo =
            object.logo == null ? null : fbb.writeString(object.logo);
        fbb.startTable();
        fbb.addInt64(0, object.id ?? 0);
        fbb.addInt64(1, object.channelID);
        fbb.addOffset(2, offsetname);
        fbb.addOffset(3, offseturl);
        fbb.addOffset(4, offsetlogo);
        fbb.addBool(5, object.hide);
        fbb.addBool(6, object.del);
        fbb.addInt64(7, object.order);
        fbb.finish(fbb.endTable());
        return object.id ?? 0;
      },
      objectFromFB: (Store store, Uint8List fbData) {
        final buffer = fb.BufferContext.fromBytes(fbData);
        final rootOffset = buffer.derefObject(0);

        final object = PlaylistItem();
        object.id = fb.Int64Reader().vTableGet(buffer, rootOffset, 4);
        object.channelID = fb.Int64Reader().vTableGet(buffer, rootOffset, 6);
        object.name = fb.StringReader().vTableGet(buffer, rootOffset, 8);
        object.url = fb.StringReader().vTableGet(buffer, rootOffset, 10);
        object.logo = fb.StringReader().vTableGet(buffer, rootOffset, 12);
        object.hide = fb.BoolReader().vTableGet(buffer, rootOffset, 14);
        object.del = fb.BoolReader().vTableGet(buffer, rootOffset, 16);
        object.order = fb.Int64Reader().vTableGet(buffer, rootOffset, 18);
        return object;
      });
  bindings[PlaylistItemGroup] = EntityDefinition<PlaylistItemGroup>(
      model: model.getEntityByUid(88792320226489959),
      toOneRelations: (PlaylistItemGroup object) => [],
      toManyRelations: (PlaylistItemGroup object) => {},
      getId: (PlaylistItemGroup object) => object.id,
      setId: (PlaylistItemGroup object, int id) {
        object.id = id;
      },
      objectToFB: (PlaylistItemGroup object, fb.Builder fbb) {
        final offsetname =
            object.name == null ? null : fbb.writeString(object.name);
        fbb.startTable();
        fbb.addInt64(0, object.id ?? 0);
        fbb.addInt64(1, object.channelID);
        fbb.addOffset(2, offsetname);
        fbb.finish(fbb.endTable());
        return object.id ?? 0;
      },
      objectFromFB: (Store store, Uint8List fbData) {
        final buffer = fb.BufferContext.fromBytes(fbData);
        final rootOffset = buffer.derefObject(0);

        final object = PlaylistItemGroup();
        object.id = fb.Int64Reader().vTableGet(buffer, rootOffset, 4);
        object.channelID = fb.Int64Reader().vTableGet(buffer, rootOffset, 6);
        object.name = fb.StringReader().vTableGet(buffer, rootOffset, 8);
        return object;
      });
  bindings[XmlTvItem] = EntityDefinition<XmlTvItem>(
      model: model.getEntityByUid(2675274788743770252),
      toOneRelations: (XmlTvItem object) => [],
      toManyRelations: (XmlTvItem object) => {},
      getId: (XmlTvItem object) => object.id,
      setId: (XmlTvItem object, int id) {
        object.id = id;
      },
      objectToFB: (XmlTvItem object, fb.Builder fbb) {
        final offsettitle =
            object.title == null ? null : fbb.writeString(object.title);
        final offsetdesc =
            object.desc == null ? null : fbb.writeString(object.desc);
        final offseticon =
            object.icon == null ? null : fbb.writeString(object.icon);
        fbb.startTable();
        fbb.addInt64(0, object.id ?? 0);
        fbb.addInt64(1, object.channelID);
        fbb.addInt64(2, object.start);
        fbb.addInt64(3, object.stop);
        fbb.addOffset(4, offsettitle);
        fbb.addOffset(5, offsetdesc);
        fbb.addOffset(6, offseticon);
        fbb.finish(fbb.endTable());
        return object.id ?? 0;
      },
      objectFromFB: (Store store, Uint8List fbData) {
        final buffer = fb.BufferContext.fromBytes(fbData);
        final rootOffset = buffer.derefObject(0);

        final object = XmlTvItem();
        object.id = fb.Int64Reader().vTableGet(buffer, rootOffset, 4);
        object.channelID = fb.Int64Reader().vTableGet(buffer, rootOffset, 6);
        object.start = fb.Int64Reader().vTableGet(buffer, rootOffset, 8);
        object.stop = fb.Int64Reader().vTableGet(buffer, rootOffset, 10);
        object.title = fb.StringReader().vTableGet(buffer, rootOffset, 12);
        object.desc = fb.StringReader().vTableGet(buffer, rootOffset, 14);
        object.icon = fb.StringReader().vTableGet(buffer, rootOffset, 16);
        return object;
      });

  return ModelDefinition(model, bindings);
}

class PlaylistItem_ {
  static final id =
      QueryIntegerProperty(entityId: 1, propertyId: 1, obxType: 6);
  static final channelID =
      QueryIntegerProperty(entityId: 1, propertyId: 2, obxType: 6);
  static final name =
      QueryStringProperty(entityId: 1, propertyId: 3, obxType: 9);
  static final url =
      QueryStringProperty(entityId: 1, propertyId: 4, obxType: 9);
  static final logo =
      QueryStringProperty(entityId: 1, propertyId: 5, obxType: 9);
  static final hide =
      QueryBooleanProperty(entityId: 1, propertyId: 6, obxType: 1);
  static final del =
      QueryBooleanProperty(entityId: 1, propertyId: 7, obxType: 1);
  static final order =
      QueryIntegerProperty(entityId: 1, propertyId: 8, obxType: 6);
}

class PlaylistItemGroup_ {
  static final id =
      QueryIntegerProperty(entityId: 2, propertyId: 1, obxType: 6);
  static final channelID =
      QueryIntegerProperty(entityId: 2, propertyId: 2, obxType: 6);
  static final name =
      QueryStringProperty(entityId: 2, propertyId: 3, obxType: 9);
}

class XmlTvItem_ {
  static final id =
      QueryIntegerProperty(entityId: 3, propertyId: 1, obxType: 6);
  static final channelID =
      QueryIntegerProperty(entityId: 3, propertyId: 2, obxType: 6);
  static final start =
      QueryIntegerProperty(entityId: 3, propertyId: 3, obxType: 6);
  static final stop =
      QueryIntegerProperty(entityId: 3, propertyId: 4, obxType: 6);
  static final title =
      QueryStringProperty(entityId: 3, propertyId: 5, obxType: 9);
  static final desc =
      QueryStringProperty(entityId: 3, propertyId: 6, obxType: 9);
  static final icon =
      QueryStringProperty(entityId: 3, propertyId: 7, obxType: 9);
}
