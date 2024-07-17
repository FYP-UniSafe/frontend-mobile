import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

Future<Uint8List> createCustomMarkerBitmapWithReportCount(
    String count, double radius) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final double size = radius * 2;

  final Paint circlePaint = Paint()..color = Colors.red.withOpacity(0.7);
  canvas.drawCircle(Offset(radius, radius), radius, circlePaint);

  final TextPainter textPainter = TextPainter(
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.center,
  );
  textPainter.text = TextSpan(
    text: count,
    style: TextStyle(
      fontSize: radius / 2,
      fontFamily: 'Montserrat',
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );
  textPainter.layout();
  textPainter.paint(
    canvas,
    Offset((size - textPainter.width) / 2, (size - textPainter.height) / 2),
  );

  final ui.Image image =
      await pictureRecorder.endRecording().toImage(size.toInt(), size.toInt());
  final ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}
