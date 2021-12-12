import 'package:flutter/material.dart';

import 'graph_widget.dart';

class GraphScreen extends StatefulWidget {
  final int n;
  const GraphScreen(this.n, {Key? key}) : super(key: key);

  @override
  _GraphScreenState createState() => _GraphScreenState(n);
}

class _GraphScreenState extends State<GraphScreen> {
  int n;
  _GraphScreenState(this.n);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: GraphWidget(n),
      ),
    );
  }
}
