import 'package:flutter/material.dart';
import 'package:signature_kit/src/controller.dart';
import 'package:signature_kit/src/signature_pianter.dart';
import 'package:signature_kit/src/singlepoint_recognizer.dart';

class Signature extends StatefulWidget {
  final SignatureController controller;

  const Signature({
    super.key,
    required this.controller,
  });

  @override
  State<StatefulWidget> createState() => SignatureState();
}

class SignatureState extends State<Signature> {
  @override
  void initState() {
    widget.controller.addListener(_handleChange);
    super.initState();
  }

  void _handleChange() {
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant Signature oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _downCallBack(PointerDownEvent pointerDownEvent) {
    widget.controller.path.moveTo(
        pointerDownEvent.localPosition.dx, pointerDownEvent.localPosition.dy);
    widget.controller.path.lineTo(
        pointerDownEvent.localPosition.dx, pointerDownEvent.localPosition.dy);
    _handleChange();
  }

  void _moveCallBack(PointerMoveEvent pointerMoveEvent) {
    widget.controller.path.lineTo(
        pointerMoveEvent.localPosition.dx, pointerMoveEvent.localPosition.dy);
    _handleChange();
  }

  void _upCallBack(PointerUpEvent pointerUpEvent) {}

  void _singleTapCallBack(PointerUpEvent pointerUpEvent) {
    widget.controller.dots.add(pointerUpEvent.localPosition);
    _handleChange();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipBehavior: Clip.antiAlias,
      child: RawGestureDetector(
        gestures: {
          SinglePointRecognizer:
              GestureRecognizerFactoryWithHandlers<SinglePointRecognizer>(
            () => SinglePointRecognizer(),
            (instance) {
              instance
                ..downCallBack = _downCallBack
                ..moveCallBack = _moveCallBack
                ..upCallBack = _upCallBack
                ..singleTapCallBack = _singleTapCallBack;
            },
          )
        },
        child: RepaintBoundary(
          key: widget.controller.signatureKey,
          child: LayoutBuilder(
            builder: (context, constrains) {
              return CustomPaint(
                size: Size(constrains.maxWidth, constrains.maxHeight),
                painter: SignaturePainter(
                  widget.controller.path,
                  widget.controller.dots,
                  color: widget.controller.color,
                  bgColor: widget.controller.backgroundColor,
                  strokeWidth: widget.controller.strokeWidth,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
