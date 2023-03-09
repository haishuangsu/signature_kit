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
    widget.controller.prePoints.add(pointerDownEvent.localPosition);
    widget.controller.currentPoints.add(pointerDownEvent.localPosition);
    _handleChange();
  }

  void _moveCallBack(PointerMoveEvent pointerMoveEvent) {
    widget.controller.prePoints.add(pointerMoveEvent.localPosition - pointerMoveEvent.delta);
    widget.controller.currentPoints.add(pointerMoveEvent.localPosition);
    _handleChange();
  }

  void _upCallBack(PointerUpEvent pointerUpEvent) {}

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipBehavior: Clip.antiAlias,
      child: RawGestureDetector(
        gestures: {
          SinglePointRecognizer: GestureRecognizerFactoryWithHandlers<SinglePointRecognizer>(
            () => SinglePointRecognizer(),
            (instance) {
              instance
                ..downCallBack = _downCallBack
                ..moveCallBack = _moveCallBack
                ..upCallBack = _upCallBack;
            },
          )
        },
        child: RepaintBoundary(
          key: widget.controller.signatureKey,
          child: CustomPaint(
            size: Size.infinite,
            painter: SignaturePainter(
              widget.controller.prePoints,
              widget.controller.currentPoints,
              color: widget.controller.color,
              bgColor: widget.controller.backgroundColor,
              strokeWidth: widget.controller.strokeWidth,
            ),
          ),
        ),
      ),
    );
  }
}
