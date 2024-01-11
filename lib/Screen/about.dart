import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late ArCoreController arCoreController;

  void onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _addImage(arCoreController);
  }

  Future<Uint8List> getImageBytes(String imageName) async {
    final ByteData data = await rootBundle.load('assets/$imageName');
    return data.buffer.asUint8List();
  }

  void _addImage(ArCoreController controller) async {
    final imagebytes = await getImageBytes("grp04.png");
    final node = ArCoreNode(
      image: ArCoreImage(bytes: imagebytes, width: 540, height: 675),
      position: vector64.Vector3(0, 0, -1.5),
    );
    controller.addArCoreNode(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(onArCoreViewCreated: onArCoreViewCreated),
    );
  }
}
