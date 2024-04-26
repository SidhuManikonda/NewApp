import 'package:flutter/material.dart';

class ImageZooming extends StatefulWidget {
  const ImageZooming({super.key});

  @override
  State<ImageZooming> createState() => _ImageZoomingState();
}

class _ImageZoomingState extends State<ImageZooming> {
  @override
  void initState() {
    controller = TransformationController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late TransformationController controller;
  TapDownDetails? tapDownDetails;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: LayoutBuilder(builder: ((context, constraints) {
        return Stack(
          children: [
            buildImage(constraints),
            Positioned(left: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.35, child: Text('data'))
          ],
        );
      })),
    ));
  }

  Widget buildImage(BoxConstraints constraints) {
    return Stack(
      children: [
        GestureDetector(
          onDoubleTapDown: (details) => tapDownDetails = details,
          onDoubleTap: () {
            final position = tapDownDetails!.localPosition;
            const scale = 3;
            final x = -position.dx * (scale - 1);
            final y = -position.dy * (scale - 1);
            final zoomed = Matrix4.identity()
              ..translate(x, y)
              ..scale(scale);
            final value =
                controller.value.isIdentity() ? zoomed : Matrix4.identity();
            controller.value = value;
          },
          child: InteractiveViewer(
            transformationController: controller,
            clipBehavior: Clip.none,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                  'assets/images/WhatsApp Image 2024-04-25 at 14.49.55_b682cd46.jpg'),
            ),
          ),
        ),
      ],
    );
  }
}
