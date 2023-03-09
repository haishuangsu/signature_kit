import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SignatureController extends ChangeNotifier {
  GlobalKey signatureKey = GlobalKey();
  var prePoints = <Offset>[];
  var currentPoints = <Offset>[];
  Color backgroundColor;
  Color color;
  double strokeWidth;

  SignatureController({
    this.backgroundColor = Colors.white,
    this.color = Colors.black,
    this.strokeWidth = 2,
  });

  Future<Uint8List> toImage({double pixelRatio = 1, ImageByteFormat format = ImageByteFormat.png}) async {
    RenderRepaintBoundary renderRepaintBoundary =
        signatureKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await renderRepaintBoundary.toImage(pixelRatio: pixelRatio);
    ByteData? data = await image.toByteData(format: format);
    return data!.buffer.asUint8List();
  }

  void clear() {
    prePoints.clear();
    currentPoints.clear();
    notifyListeners();
  }
}
