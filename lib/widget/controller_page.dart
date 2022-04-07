
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ControllerPage extends StatelessWidget {

  final TextEditingController controller = TextEditingController(text: 'init Text');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ControllerDemoPage'),
      ),
      extendBody: true,
      body: Column(
        children: [
          Expanded(child: InkWell(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          )),
          CustomWidget(),
          Container(
            margin: EdgeInsets.all(10),
            child: Center(
              child: TextField(
                controller: controller,
              ),
            ),
          ),
          Spacer()
        ],
      ),
    );

  }
}

class CustomWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

