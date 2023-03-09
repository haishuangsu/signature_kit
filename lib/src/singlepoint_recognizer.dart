import 'package:flutter/gestures.dart';

typedef OnePointerDownCallBack = void Function(PointerDownEvent downEvent);
typedef OnePointerMoveCallBack = void Function(PointerMoveEvent moveEvent);
typedef OnePointerUpCallBack = void Function(PointerUpEvent upEvent);

class SinglePointRecognizer extends OneSequenceGestureRecognizer {
  OnePointerDownCallBack? downCallBack;
  OnePointerMoveCallBack? moveCallBack;
  OnePointerUpCallBack? upCallBack;

  @override
  String get debugDescription => 'SinglePointerRecognizer';

  bool pointerActive = false;

  @override
  void addAllowedPointer(PointerDownEvent event) {
    if (pointerActive) {
      return;
    }
    super.addAllowedPointer(event);
  }

  @override
  void didStopTrackingLastPointer(int pointer) {}

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerDownEvent) {
      pointerActive = true;
      downCallBack!.call(event);
    } else if (event is PointerMoveEvent) {
      moveCallBack!.call(event);
    } else if (event is PointerUpEvent) {
      upCallBack!.call(event);
      pointerActive = false;
    }
  }
}
