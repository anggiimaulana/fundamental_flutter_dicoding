import 'package:flutter/material.dart';

class MyContainerWidget extends StatefulWidget {
  const MyContainerWidget({super.key});

  @override
  State<MyContainerWidget> createState() => _MyContainerWidgetState();
}

class _MyContainerWidgetState extends State<MyContainerWidget> {
  // todo-double-tap-01: create a variable size for zoom instantly and add fixedSize for specific size
  double _baseSize = 150;
  final List<double> _fixedSize = const [150, 250, 350];

  // todo-scale-01: create a variable scale for zoom
  double _baseScaleFactor = 0.5;
  double _scaleFactor = 1.0;
  @override
  Widget build(BuildContext context) {
    // todo-double-tap-02: wrap with GestureDetector

    // todo-double-tap-03: add onDoubleTap callback and set the baseSize

    // todo-scale-02: wrap this widget with Transform.scale and add scale parameter

    // todo-scale-03: add some callback for scale the GestureDetector widget

    // todo-scale-04: set scale value to default on onDoubleTap callback
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          _baseSize = switch (_baseSize) {
            <= 150 => _fixedSize[1],
            <= 250 => _fixedSize[2],
            <= 350 => _fixedSize[0],
            _ => _fixedSize[1],
          };
          _baseScaleFactor = 1.0;
        });
      },
      onScaleStart: (details) {
        _scaleFactor = _baseScaleFactor;
      },
      onScaleUpdate: (details) {
        setState(() {
          _baseScaleFactor = _scaleFactor * details.scale;
        });
      },
      child: Transform.scale(
        scale: _baseScaleFactor,
        child: Image.network(
          "https://th.bing.com/th/id/OIP.o3uWxNqRWqE8BooPMtmOMQHaEt?rs=1&pid=ImgDetMain",
          fit: BoxFit.cover,
          // todo-double-tap-04: change width and height into the baseSize variable
          height: _baseSize,
          width: _baseSize,
        ),
      ),
    );
  }
}
