

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// widget布局

void main() {
  runApp(
    const MaterialApp(
      home: WidgetLayout(),
    )
  );
}

class WidgetLayout extends StatelessWidget {
  const WidgetLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildHomePage();
  }

  Widget _buildHomePage() {
    final stars = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        const Icon(Icons.star, color: Colors.black),
        const Icon(Icons.star, color: Colors.black),
      ],
    );

    final catRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Image.asset('images/img_cat.png'),
        ),
        Expanded(
          flex: 1,
          child: Image.asset('images/img_cat.png'),
        ),
        Expanded(
          child: Image.asset('images/img_cat.png'),
        )
      ],
    );

    var image = Expanded(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 10, color: Colors.black38),
            borderRadius: const BorderRadius.all(Radius.circular(8))
          ),
          margin: const EdgeInsets.all(4),
          child: Image.asset("images/img_cat.png"),
        )
    );

    final imageRow = Row(
      children: [
        image,
        image,
      ],
    );

    final imageContainer = Container(
      decoration: const BoxDecoration(
          color: Colors.black26
      ),
      child: Column(
        children: [
          imageRow,
          imageRow
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Widget Layout"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          catRow,
          stars,
          imageContainer
        ],
      )
    );
  }
}



/// 文本样式
const descTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w800,
  fontFamily: '',
  letterSpacing: 0.5,
  fontSize: 18,
  height: 2
);

/// DefaultTextStyle里的文本统一使用定义的style
final iconList = DefaultTextStyle.merge(
    style: descTextStyle,
    child: Container()
);



