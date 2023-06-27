import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircleClipper extends CustomClipper<Path> {
  const CircleClipper();
  @override
  Path getClip(Size size) {
    var path = Path();

    final rect = Rect.fromCircle(
      center: Offset(
        size.width / 2,
        size.height / 2,
      ),
      radius: size.width / 2,
    );

    path.addOval(rect);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

///
/// create a new random color.
///
Color getRandomColor() => Color(
      0xFF000000 +
          math.Random().nextInt(
            0x00FFFFFF,
          ),
    );

class Example6TweenAnimation extends StatefulWidget {
  const Example6TweenAnimation({super.key});

  @override
  State<Example6TweenAnimation> createState() => _Example6TweenAnimationState();
}

class _Example6TweenAnimationState extends State<Example6TweenAnimation> {
  var _color = getRandomColor();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: ClipPath(
          clipper: const CircleClipper(),
          child: TweenAnimationBuilder(
            duration: const Duration(seconds: 1),
            tween: ColorTween(
              begin: getRandomColor(),
              end: _color,
            ),
            child: Container(
              color: Colors.red,
              width: size.width,
              height: size.width,
            ),
            onEnd: () {
              setState(() {
                _color = getRandomColor();
              });
            },
            builder: (context, Color? value, child) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(
                  value!,
                  BlendMode.srcATop,
                ),
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}
