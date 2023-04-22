import 'package:flutter/material.dart';

class SignaturePainter extends CustomPainter {
  Paint linePaint;

  Path path;
  List<Offset> dots;

  final Color bgColor;
  final Color color;
  final double strokeWidth;

  SignaturePainter(
    this.path,
    this.dots, {
    required this.color,
    required this.bgColor,
    required this.strokeWidth,
  }) : linePaint = Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = bgColor);

    canvas.drawPath(path, linePaint);
    for (var dot in dots) {
      canvas.drawCircle(dot, strokeWidth / 2, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant SignaturePainter oldDelegate) {
    return true;
  }
}
