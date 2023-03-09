import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:signature_kit/signature_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signature_kit Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SignatureController controller = SignatureController(
    backgroundColor: Colors.black,
    color: Colors.white,
    strokeWidth: 3,
  );
  Uint8List? pngData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signature_kit Example'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  pngData = await controller.toImage(
                      pixelRatio: MediaQuery.of(context).devicePixelRatio, format: ImageByteFormat.png);
                  setState(() {});
                },
                child: const Text('export'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  controller.clear();
                  pngData = null;
                  setState(() {});
                },
                child: const Text('clear'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 300,
            child: Signature(controller: controller),
          ),
          const SizedBox(height: 30),
          pngData != null ? Image.memory(pngData!) : const SizedBox(),
        ],
      ),
    );
  }
}
