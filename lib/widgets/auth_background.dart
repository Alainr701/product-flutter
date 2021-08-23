import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        painter: _HeaderPainter(),
        child: Center(
          child: this.child,
        ),
      ),
    );
  }
}

class _HeaderPainter extends CustomPainter {
  final Rect rect = Rect.fromCircle(center: Offset(0.0, 55.0), radius: 180);
  final Gradient gradient =
      new LinearGradient(colors: [Colors.blue, Colors.red]);

  @override
  void paint(Canvas canvas, Size size) {
    //pencil
    final paint = new Paint();
    paint.shader = gradient.createShader(rect);
    // paint.color = Colors.red;
    // paint.style = PaintingStyle.stroke;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    final path = new Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.05);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.1,
        size.width * 0.5, size.height * 0.05);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.01, size.width, size.height * 0.06);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);

    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.95);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.9,
        size.width * 0.5, size.height * 0.95);
    path.quadraticBezierTo(
        size.width * 0.7, size.height * 0.98, size.width, size.height * 0.95);
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
