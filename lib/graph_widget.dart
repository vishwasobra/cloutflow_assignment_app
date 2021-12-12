import 'dart:math';

import 'package:flutter/material.dart';
import 'list_element.dart';
import 'color_list.dart';

class GraphWidget extends StatefulWidget {
  final int n;
  const GraphWidget(this.n, {Key? key}) : super(key: key);

  @override
  _GraphWidgetState createState() => _GraphWidgetState(n);
}

class _GraphWidgetState extends State<GraphWidget> {
  final int n;
  _GraphWidgetState(this.n) : super();

  List<ListElement> list = [];
  @override
  void initState() {
    didUpdateWidget(widget);
    super.initState();
  }

  @override
  void didUpdateWidget(GraphWidget oldWidget) {
    list = List.generate(n, (index) => ListElement(0, 0));
    updateState(list);

    super.didUpdateWidget(oldWidget);
  }

  void updateState(List<ListElement> list) async {
    int n = list.length;
    for (int i = 0; i < n; i++) {
      list[i].initialIndex = i;
      list[i].value = Random().nextInt(81) + 20;
    }

    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        if (list[j].value > list[j + 1].value) {
          // Swapping using temporary variable
          ListElement temp = list[j];
          list[j] = list[j + 1];
          list[j + 1] = temp;
          await Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {});
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth - 20,
      height: (screenWidth - 20) * (9 / 16),
      child: CustomPaint(
        painter: GraphPainter(list),
      ),
    );
  }
}

class GraphPainter extends CustomPainter {
  final List<ListElement> list;
  GraphPainter(this.list);

  @override
  void paint(Canvas canvas, Size size) {
    // Drawing Graph Outline
    var strokeBrush = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), strokeBrush);

    // Drawing Graph Title
    var graphTitleText = const TextSpan(
      text: 'Graph of Elements and their value',
      style: TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w900,
        fontSize: 20,
      ),
    );
    var graphTitlePainter = TextPainter(
      text: graphTitleText,
      textDirection: TextDirection.ltr,
    );
    graphTitlePainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    var offset1 = Offset((size.width - graphTitlePainter.width) / 2, 10);
    graphTitlePainter.paint(canvas, offset1);

    // Drawing Axes
    var origin = Offset(50 + 15, size.height - 40 - 15);
    canvas.drawLine(
        origin, Offset(origin.dx, 10 + graphTitlePainter.height + 10), strokeBrush); // Y Axis
    canvas.drawLine(Offset(origin.dx - 5, origin.dy), Offset(size.width - 10, origin.dy),
        strokeBrush); // X Axis

    // Drawing X Axis Title
    var xAxisTitleText = const TextSpan(
      text: 'Initial Index',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w900,
        fontSize: 13,
      ),
    );
    var xAxisTitlePainter = TextPainter(
      text: xAxisTitleText,
      textDirection: TextDirection.ltr,
    );
    xAxisTitlePainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    var offset2 = Offset((origin.dx + size.width - 10 - xAxisTitlePainter.width) / 2,
        size.height - xAxisTitlePainter.height - 10);
    xAxisTitlePainter.paint(canvas, offset2);

    // Drawing Y Axis Title
    canvas.save();

    var yAxisTitleText = const TextSpan(
      text: 'Value of Element',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w900,
        fontSize: 13,
      ),
    );
    var yAxisTitlePainter = TextPainter(
      text: yAxisTitleText,
      textDirection: TextDirection.ltr,
    );
    yAxisTitlePainter.layout(
      minWidth: 0,
      maxWidth: size.height,
    );
    canvas.translate(0, size.height);
    canvas.rotate(-pi / 2);
    var offset3 = Offset(
        40 +
            xAxisTitlePainter.height +
            (size.height - 60 - xAxisTitlePainter.height - graphTitlePainter.height) / 2 -
            yAxisTitlePainter.width / 2,
        10);
    yAxisTitlePainter.paint(canvas, offset3);

    canvas.restore();

    // Drawing Y Axis Labels and Horizontal lines

    var labelPainter = getLabelPainter('0', 10, TextAlign.right);
    labelPainter.paint(canvas, Offset(origin.dx - 30, origin.dy - labelPainter.height / 2));
    var yAxisLength = size.height - 60 - xAxisTitlePainter.height - graphTitlePainter.height;
    double dy = origin.dy - (yAxisLength / 10);
    labelPainter = getLabelPainter('10', 10, TextAlign.right);
    labelPainter.paint(canvas, Offset(origin.dx - 30, dy - labelPainter.height / 2));
    canvas.drawLine(Offset(origin.dx - 5, dy), Offset(size.width - 10, dy), strokeBrush);
    dy -= yAxisLength / 10;
    labelPainter = getLabelPainter('20', 10, TextAlign.right);
    labelPainter.paint(canvas, Offset(origin.dx - 30, dy - labelPainter.height / 2));
    canvas.drawLine(Offset(origin.dx - 5, dy), Offset(size.width - 10, dy), strokeBrush);
    dy -= yAxisLength / 10;
    labelPainter = getLabelPainter('30', 10, TextAlign.right);
    labelPainter.paint(canvas, Offset(origin.dx - 30, dy - labelPainter.height / 2));
    canvas.drawLine(Offset(origin.dx - 5, dy), Offset(size.width - 10, dy), strokeBrush);
    dy -= yAxisLength / 10;
    labelPainter = getLabelPainter('40', 10, TextAlign.right);
    labelPainter.paint(canvas, Offset(origin.dx - 30, dy - labelPainter.height / 2));
    canvas.drawLine(Offset(origin.dx - 5, dy), Offset(size.width - 10, dy), strokeBrush);
    dy -= yAxisLength / 10;
    labelPainter = getLabelPainter('50', 10, TextAlign.right);
    labelPainter.paint(canvas, Offset(origin.dx - 30, dy - labelPainter.height / 2));
    canvas.drawLine(Offset(origin.dx - 5, dy), Offset(size.width - 10, dy), strokeBrush);
    dy -= yAxisLength / 10;
    labelPainter = getLabelPainter('60', 10, TextAlign.right);
    labelPainter.paint(canvas, Offset(origin.dx - 30, dy - labelPainter.height / 2));
    canvas.drawLine(Offset(origin.dx - 5, dy), Offset(size.width - 10, dy), strokeBrush);
    dy -= yAxisLength / 10;
    labelPainter = getLabelPainter('70', 10, TextAlign.right);
    labelPainter.paint(canvas, Offset(origin.dx - 30, dy - labelPainter.height / 2));
    canvas.drawLine(Offset(origin.dx - 5, dy), Offset(size.width - 10, dy), strokeBrush);
    dy -= yAxisLength / 10;
    labelPainter = getLabelPainter('80', 10, TextAlign.right);
    labelPainter.paint(canvas, Offset(origin.dx - 30, dy - labelPainter.height / 2));
    canvas.drawLine(Offset(origin.dx - 5, dy), Offset(size.width - 10, dy), strokeBrush);
    dy -= yAxisLength / 10;
    labelPainter = getLabelPainter('90', 10, TextAlign.right);
    labelPainter.paint(canvas, Offset(origin.dx - 30, dy - labelPainter.height / 2));
    canvas.drawLine(Offset(origin.dx - 5, dy), Offset(size.width - 10, dy), strokeBrush);
    dy -= yAxisLength / 10;
    labelPainter = getLabelPainter('100', 10, TextAlign.right);
    labelPainter.paint(canvas, Offset(origin.dx - 30, dy - labelPainter.height / 2));
    canvas.drawLine(Offset(origin.dx - 5, dy), Offset(size.width - 10, dy), strokeBrush);

    // Paint Elements
    paintElements(canvas, size, origin, yAxisLength, size.width - 10 - origin.dx, list);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  TextPainter getLabelPainter(String text, double fontSize, TextAlign textAlign) {
    var labelText = TextSpan(
      text: text,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
      ),
    );
    var labelPainter = TextPainter(
      text: labelText,
      textAlign: textAlign,
      textDirection: TextDirection.ltr,
    );
    labelPainter.layout(
      minWidth: 20,
      maxWidth: 20,
    );
    return labelPainter;
  }

  void paintElements(Canvas canvas, Size size, Offset origin, double yAxisLength,
      double xAxisLength, List<ListElement> list) {
    double space = xAxisLength / (2 * list.length + 1);

    TextPainter labelPainter;
    Paint fillBrush;

    for (int i = 0; i < list.length; i++) {
      labelPainter = getLabelPainter(list[i].initialIndex.toString(), 10, TextAlign.center);
      labelPainter.paint(canvas, Offset(origin.dx + (2 * i + 1) * space, origin.dy + 10));
      fillBrush = Paint()..color = colors[list[i].value ~/ 10 - 2];
      canvas.drawRect(
          Rect.fromLTWH(
              origin.dx + (2 * i + 1) * space,
              origin.dy - (yAxisLength / 100) * list[i].value,
              space,
              ((yAxisLength / 100) * list[i].value).toDouble()),
          fillBrush);
    }
  }
}
