// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

class Polygon extends CustomPainter {
  final int sides;
  Polygon({
    required this.sides,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // TODO
    // Create a paint.
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;
    // create a path.
    final path = Path();
    // create offset x and y center.
    final center = Offset(size.width / 2, size.width / 2);
    final angle = (2 * pi) / sides;
  
    final angles = List.generate(sides, (index) => index * angle);

    final radius = size.width / 2;

    /*
    x = center.x + radius*cos(angle);
    y = center.y + radius*sin(angle);
    */

    path.moveTo(
      center.dx + radius * cos(0),
      center.dy + radius * sin(0),
    );

    for (final angle in angles) {
      path.lineTo(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
    }

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is Polygon && oldDelegate.sides != sides;
}

class Example7CustomPain extends StatefulWidget {
  const Example7CustomPain({super.key});

  @override
  State<Example7CustomPain> createState() => _Example7CustomPainState();
}

class _Example7CustomPainState extends State<Example7CustomPain>
    with TickerProviderStateMixin {
  late AnimationController _sidesController;
  late Animation<int> _sidesnimation;

  late AnimationController _radiusController;
  late Animation<double> _radiusAnimation;
  @override
  void initState() {
    super.initState();
    _sidesController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _sidesnimation = IntTween(
      begin: 3,
      end: 10,
    ).animate(_sidesController);

    _radiusController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _radiusAnimation = Tween(
      begin: 20.0,
      end: 400.0,
    )
        .chain(
          CurveTween(
            curve: Curves.bounceInOut,
          ),
        )
        .animate(_radiusController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _sidesController.dispose();
    _radiusController.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _sidesController.repeat(reverse: true);
    _radiusController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            animation: Listenable.merge(
              [
                _sidesController,
                _radiusController,
              ],
            ),
            builder: (context, child) {
              return CustomPaint(
                painter: Polygon(
                  sides: _sidesnimation.value,
                ),
                child: SizedBox(
                  height: _radiusAnimation.value,
                  width: _radiusAnimation.value,
                ),
              );
            }),
      ),
    );
  }
}
