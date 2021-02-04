import 'package:flutter/material.dart';
import 'package:itv/models/Playlist.dart';
import 'package:itv/models/PlaylistItem.dart';
import 'package:itv/widget/Player.dart';
import 'package:itv/widget/PlaylistItem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var routes = <String, WidgetBuilder>{
      M3UPlayer.routeName: (BuildContext context) => new M3UPlayer(),
    };
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    Playlist.cls.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("iTv"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_rounded),
            onPressed: () {
              Playlist.cls.refresh();
              setState(() {});
            },
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          PopupMenuButton<int>(
            onSelected: (v) {
              switch (v) {
                case 1:
                  Playlist.showHide = !Playlist.showHide;
                  break;
              }
              setState(() {});
            },
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            icon: Icon(Icons.filter_list),
            tooltip: "Фильтр",
            itemBuilder: (context) => [
              CheckedPopupMenuItem(
                value: 1,
                child: Text("Показывать скрытые"),
                checked: Playlist.showHide,
              ),
            ],
          ),
          PopupMenuButton<int>(
            onSelected: (v) {
              Playlist.sortSel = v;
              setState(() {});
            },
            icon: Icon(Icons.sort),
            tooltip: "Сортировка",
            initialValue: Playlist.sortSel,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: 1,
                child: Text("По номеру"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("По имени"),
              ),
              PopupMenuItem(
                value: 3,
                child: Text("По id"),
              )
            ],
          ),
        ],
      ),
      body: FutureBuilder(
          future: Playlist.cls.initial(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: ListTile(
                  leading: Icon(Icons.warning),
                  title: Text(snapshot.error.toString()),
                ),
              );
            }
            if (Playlist.cls.items.isEmpty) {
              // errror
            }
            switch (Playlist.sortSel) {
              case 1:
                Playlist.cls.items.sort((a, b) => a.order.compareTo(b.order));
                break;
              case 2:
                Playlist.cls.items.sort((a, b) =>
                    a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                break;
              case 3:
                Playlist.cls.items
                    .sort((a, b) => a.channelID.compareTo(b.channelID));
                break;
            }
            return ListView.builder(
                itemCount: Playlist.cls.items.length,
                itemBuilder: (ctx, ix) {
                  PlaylistItem item = Playlist.cls.items[ix];
                  return PlaylistItemWidget(item: item);
                });
          }),
    );
  }
}
