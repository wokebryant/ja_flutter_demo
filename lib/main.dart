
import 'package:flutter/material.dart';
import 'package:window_location_href/window_location_href.dart';

import 'route_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ja Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomepage(title: "Ja Flutter Demo",),
      routes: routers,
    );
  }
}

class MyHomepage extends StatefulWidget {
  final String? title;

  const MyHomepage({Key? key, this.title}) : super(key: key);

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {

  @override
  void initState() {
    super.initState();
    final href = getHref();
    int? index = href?.indexOf("#");
    if (href != null && index != null && index > 0) {
      String uri = href;
      String key = uri.substring(index + 1, uri.length);
      if (key.isNotEmpty && key.length > 3) {
        var result = Uri.decodeFull(key);
        if (key.isNotEmpty && key.length > 3) {
          Future(() => Navigator.pushNamed(context, result));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var routeLists = routers.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Container(
        child: ListView.builder(
            itemBuilder: (context, index) => InkWell(
              // InkWell组件，支持点击效果
              onTap: () => Navigator.of(context).pushNamed(routeLists[index]),
              child: Card(
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  child: Text(routeLists[index]),
                ),
              ),
            ),
          itemCount: routeLists.length,
        ),
      ),
    );
  }
}





