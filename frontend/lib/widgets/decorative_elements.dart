import 'package:flutter/material.dart';
import 'dart:math' as math;

// Butterfly decorative element
class ButterflyDecoration extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;

  const ButterflyDecoration({
    super.key,
    this.size = 40,
    this.color = const Color(0xFF10B981),
    this.opacity = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ButterflyPainter(color: color.withOpacity(opacity)),
    );
  }
}

class _ButterflyPainter extends CustomPainter {
  final Color color;

  _ButterflyPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final wingSize = size.width / 3;

    // Left wing
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(centerX - wingSize * 0.6, centerY),
        width: wingSize * 1.2,
        height: wingSize * 1.5,
      ),
      paint,
    );

    // Right wing
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(centerX + wingSize * 0.6, centerY),
        width: wingSize * 1.2,
        height: wingSize * 1.5,
      ),
      paint,
    );

    // Body
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawLine(
      Offset(centerX, centerY - wingSize),
      Offset(centerX, centerY + wingSize),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Nature leaf decoration
class LeafDecoration extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;

  const LeafDecoration({
    super.key,
    this.size = 30,
    this.color = const Color(0xFF10B981),
    this.opacity = 0.25,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _LeafPainter(color: color.withOpacity(opacity)),
    );
  }
}

class _LeafPainter extends CustomPainter {
  final Color color;

  _LeafPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.3,
      size.width * 0.6,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.7,
      size.width / 2,
      size.height,
    );
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.7,
      size.width * 0.4,
      size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.3,
      size.width / 2,
      0,
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Brain/Neural network decoration
class BrainDecoration extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;

  const BrainDecoration({
    super.key,
    this.size = 50,
    this.color = const Color(0xFF10B981),
    this.opacity = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _BrainPainter(color: color.withOpacity(opacity)),
    );
  }
}

class _BrainPainter extends CustomPainter {
  final Color color;

  _BrainPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 3;

    // Draw brain-like shape with connected nodes
    final nodes = [
      Offset(centerX - radius * 0.5, centerY - radius * 0.3),
      Offset(centerX + radius * 0.5, centerY - radius * 0.3),
      Offset(centerX - radius * 0.3, centerY),
      Offset(centerX + radius * 0.3, centerY),
      Offset(centerX - radius * 0.4, centerY + radius * 0.4),
      Offset(centerX + radius * 0.4, centerY + radius * 0.4),
    ];

    // Draw connections
    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        if (math.Random(i * j).nextDouble() > 0.5) {
          canvas.drawLine(nodes[i], nodes[j], paint);
        }
      }
    }

    // Draw nodes
    paint.style = PaintingStyle.fill;
    for (final node in nodes) {
      canvas.drawCircle(node, 3, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Robot/tech geometric decoration
class RobotDecoration extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;

  const RobotDecoration({
    super.key,
    this.size = 40,
    this.color = const Color(0xFF10B981),
    this.opacity = 0.25,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _RobotPainter(color: color.withOpacity(opacity)),
    );
  }
}

class _RobotPainter extends CustomPainter {
  final Color color;

  _RobotPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final boxSize = size.width / 3;

    // Robot head (square)
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX, centerY - boxSize * 0.3),
        width: boxSize,
        height: boxSize,
      ),
      paint,
    );

    // Eyes
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX - boxSize * 0.2, centerY - boxSize * 0.3), 3, paint);
    canvas.drawCircle(Offset(centerX + boxSize * 0.2, centerY - boxSize * 0.3), 3, paint);

    // Body (rectangle)
    paint.style = PaintingStyle.stroke;
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX, centerY + boxSize * 0.5),
        width: boxSize * 1.2,
        height: boxSize * 1.2,
      ),
      paint,
    );

    // Arms
    canvas.drawLine(
      Offset(centerX - boxSize * 0.6, centerY + boxSize * 0.2),
      Offset(centerX - boxSize * 1.2, centerY + boxSize * 0.5),
      paint,
    );
    canvas.drawLine(
      Offset(centerX + boxSize * 0.6, centerY + boxSize * 0.2),
      Offset(centerX + boxSize * 1.2, centerY + boxSize * 0.5),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Floating decorative background
class FloatingDecorations extends StatelessWidget {
  final Widget child;

  const FloatingDecorations({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        // Top right butterfly
        Positioned(
          top: 20,
          right: 20,
          child: Transform.rotate(
            angle: -0.3,
            child: const ButterflyDecoration(size: 35, opacity: 0.15),
          ),
        ),
        // Top left leaf
        Positioned(
          top: 40,
          left: 30,
          child: Transform.rotate(
            angle: 0.5,
            child: const LeafDecoration(size: 25, opacity: 0.12),
          ),
        ),
        // Bottom right brain
        Positioned(
          bottom: 30,
          right: 40,
          child: const BrainDecoration(size: 45, opacity: 0.1),
        ),
        // Bottom left robot
        Positioned(
          bottom: 50,
          left: 25,
          child: Transform.rotate(
            angle: 0.2,
            child: const RobotDecoration(size: 30, opacity: 0.12),
          ),
        ),
      ],
    );
  }
}

// Section divider with decorative elements
class DecorativeDivider extends StatelessWidget {
  const DecorativeDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const LeafDecoration(size: 20, opacity: 0.2),
          const SizedBox(width: 12),
          Container(
            width: 60,
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  const Color(0xFF10B981).withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          const ButterflyDecoration(size: 20, opacity: 0.2),
          const SizedBox(width: 12),
          Container(
            width: 60,
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  const Color(0xFF10B981).withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          const BrainDecoration(size: 20, opacity: 0.2),
        ],
      ),
    );
  }
}
