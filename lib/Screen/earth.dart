import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;

class EarthScreen extends StatefulWidget {
  const EarthScreen({super.key});

  @override
  State<EarthScreen> createState() => _EarthScreenState();
}

class _EarthScreenState extends State<EarthScreen> {
  ArCoreController? arCoreController;

  void onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    earthMap(arCoreController!);
  }

  earthMap(ArCoreController coreController) async {
    final ByteData EarthMap = await rootBundle.load("assets/earth_map.jpg");

    final material = ArCoreMaterial(
        color: Colors.white, textureBytes: EarthMap.buffer.asUint8List());

    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.3,
    );

    final node = ArCoreNode(
      shape: sphere,
      position: vector64.Vector3(0, 0, -1.5),
    );
    arCoreController!.addArCoreNode(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(onArCoreViewCreated: onArCoreViewCreated),
    );
  }
}
