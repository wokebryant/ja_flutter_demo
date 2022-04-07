import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(
    const MaterialApp(
      home: LayoutGridView(),
    )
  );
}

class LayoutGridView extends StatelessWidget {
  const LayoutGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GridView"),
      ),
      body: _buildGrid()
    );
  }

  Widget _buildGrid() => GridView.extent(
    maxCrossAxisExtent: 150,
    padding: const EdgeInsets.all(4),
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    children: _buildGridTileList(30),
  );

  List<Container> _buildGridTileList(int length) => List.generate(
      length, (index) => Container(child: Image.asset("images/img_cat.png"))
  );
}
