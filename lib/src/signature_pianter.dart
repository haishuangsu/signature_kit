import 'package:flutter/material.dart';

class SignaturePainter extends CustomPainter {
  Paint linePaint;

  List<Offset> prePoints;
  List<Offset> currentPoints;
  final Color bgColor;
  final Color color;
  final double strokeWidth;

  SignaturePainter(
    this.prePoints,
    this.currentPoints, {
    required this.color,
    required this.bgColor,
    required this.strokeWidth,
  }) : linePaint = Paint()
          ..color = color
          ..strokeWidth = strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = bgColor);

    for (var i = 0; i < prePoints.length; i++) {
      if (!size.contains(prePoints[i])) continue;
      if (prePoints[i] == currentPoints[i]) {
        canvas.drawCircle(prePoints[i], strokeWidth / 2, linePaint);
      } else {
        canvas.drawLine(prePoints[i], currentPoints[i], linePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant SignaturePainter oldDelegate) {
    return true;
  }
}
