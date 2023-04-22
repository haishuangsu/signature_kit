<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A Flutter package for drawing smooth signatures, easy to export image data. 

![Screenshot](https://github.com/haishuangsu/signature_kit/blob/master/screenshot/screenshot.gif)

## Getting started

This will add a line like this to your package's pubspec.yaml (and run an implicit flutter pub get):

```yaml
dependencies:
  signature_kit: ^0.0.1
```


## Usage

```dart
import 'package:signature_kit/signature_kit.dart';

  SignatureController controller = SignatureController(
    backgroundColor: Colors.black,
    color: Colors.white,
    strokeWidth: 3,
  );
  
  Signature(controller: controller)
  
  // export to png
  final pngData = await controller.toImage(pixelRatio: MediaQuery.of(context).devicePixelRatio, format: ImageByteFormat.png);

  //clear
  controller.clear();
```

