import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<Uint8List> createCustomMarkerBitmapWithText(String text) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint paint = Paint()..color = Colors.red;
  final double textWidth = (text.length * 50).toDouble();
  final double width = textWidth > 100.0 ? textWidth : 100.0;
  final double height = 300.0;

  final double textPadding = 5.0;
  final double pinHeight = 150.0;
  final double pinWidth = 75.0;
  final double pinHeadRadius = pinWidth / 2;

  final TextPainter textPainter = TextPainter(
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
  );

  textPainter.text = TextSpan(
    text: text,
    style: TextStyle(
      fontSize: 50.0,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );

  textPainter.layout();
  textPainter.paint(
    canvas,
    Offset((width - textPainter.width) * 0.5, textPadding),
  );

  final double pinStartY = textPainter.height + textPadding * 2;

  canvas.drawCircle(
    Offset(width / 2, pinStartY + pinHeadRadius),
    pinHeadRadius,
    paint,
  );

  final Path pinPath = Path()
    ..moveTo((width - pinWidth) / 2, pinStartY + pinHeadRadius)
    ..lineTo((width + pinWidth) / 2, pinStartY + pinHeadRadius)
    ..lineTo(width / 2, pinStartY + pinHeight)
    ..close();

  canvas.drawPath(pinPath, paint);

  final ui.Image image = await pictureRecorder
      .endRecording()
      .toImage(width.toInt(), height.toInt());
  final ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}
