import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:itv/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

Store _store;

Future<Store> getStore() async {
  final Directory dir = await getApplicationDocumentsDirectory();
  _store = Store(getObjectBoxModel(), directory: dir.path);
  return _store;
}

String generateMd5([List<dynamic> args]) {
  args.runtimeType.toString();
  final String input = args.map((e) {
    final String t = e.runtimeType.toString();
    switch (t) {
      case "String":
        return e;
      case "int":
        return e.toString();
      case "double":
        return e.toString();
      default:
        throw Exception("Not support type: $t");
    }
  }).join(";");
  return md5.convert(utf8.encode(input)).toString();
}

int getTimestampXmlTv(String s) {
  return (DateTime.parse(s.substring(0, 8) + 'T' + s.substring(8))
              .millisecondsSinceEpoch /
          1000)
      .truncate();
}
