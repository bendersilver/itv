import 'package:flutter/material.dart';
import 'package:itv/models/Playlist.dart';
import 'package:itv/models/PlaylistItem.dart';
import 'package:itv/widget/PlaylistItem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
          DropdownButtonHideUnderline(
              child: DropdownButton<String>(
            iconEnabledColor: Colors.white,
            icon: Icon(Icons.filter_list),
            items: <String>['A', 'B', 'C', 'D'].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (_) {},
          )),
          IconButton(icon: Icon(Icons.filter_list), onPressed: () {}),
          IconButton(icon: Icon(Icons.sort), onPressed: () {})
        ],
      ),
      body: FutureBuilder(
          future: Playlist.cls.initial(),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasError) {
              return Center(
                child: ListTile(
                  leading: Icon(Icons.warning),
                  title: Text(snapshot.error.toString()),
                ),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (Playlist.cls.items.isEmpty) {
              // errror
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
