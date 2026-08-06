import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/app_theme.dart';

class ButterflyDecoration extends StatelessWidget {
  final double size;
  final double opacity;

  const ButterflyDecoration({
    super.key,
    this.size = 40,
    this.opacity = 0.08,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ButterflyPainter(color: AppColors.emerald.withOpacity(opacity)),
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

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(centerX - wingSize * 0.6, centerY),
        width: wingSize * 1.2,
        height: wingSize * 1.5,
      ),
      paint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(centerX + wingSize * 0.6, centerY),
        width: wingSize * 1.2,
        height: wingSize * 1.5,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LeafDecoration extends StatelessWidget {
  final double size;
  final double opacity;

  const LeafDecoration({super.key, this.size = 30, this.opacity = 0.06});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _LeafPainter(color: AppColors.emerald.withOpacity(opacity)),
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
      size.width * 0.8, size.height * 0.3, size.width * 0.6, size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.5, size.height * 0.7, size.width / 2, size.height,
    );
    path.quadraticBezierTo(
      size.width * 0.5, size.height * 0.7, size.width * 0.4, size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.2, size.height * 0.3, size.width / 2, 0,
    );
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BrainDecoration extends StatelessWidget {
  final double size;
  final double opacity;

  const BrainDecoration({super.key, this.size = 50, this.opacity = 0.06});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _BrainPainter(color: AppColors.emerald.withOpacity(opacity)),
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
      ..strokeWidth = 1.5;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 3;

    final nodes = [
      Offset(centerX - radius * 0.5, centerY - radius * 0.3),
      Offset(centerX + radius * 0.5, centerY - radius * 0.3),
      Offset(centerX, centerY),
      Offset(centerX - radius * 0.4, centerY + radius * 0.4),
      Offset(centerX + radius * 0.4, centerY + radius * 0.4),
    ];

    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        if (math.Random(i * j).nextDouble() > 0.5) {
          canvas.drawLine(nodes[i], nodes[j], paint);
        }
      }
    }

    paint.style = PaintingStyle.fill;
    for (final node in nodes) {
      canvas.drawCircle(node, 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FloatingDecorations extends StatelessWidget {
  final Widget child;

  const FloatingDecorations({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: 60,
          right: -10,
          child: Transform.rotate(
            angle: -0.3,
            child: const ButterflyDecoration(size: 28, opacity: 0.05),
          ),
        ),
        Positioned(
          top: 200,
          left: -20,
          child: Transform.rotate(
            angle: 0.5,
            child: const LeafDecoration(size: 22, opacity: 0.04),
          ),
        ),
        Positioned(
          bottom: 120,
          right: 0,
          child: const BrainDecoration(size: 36, opacity: 0.04),
        ),
      ],
    );
  }
}

class DecorativeDivider extends StatelessWidget {
  const DecorativeDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Container(height: 1, color: AppColors.border)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const LeafDecoration(size: 14, opacity: 0.15),
                const SizedBox(width: 10),
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: AppColors.emerald,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                const ButterflyDecoration(size: 14, opacity: 0.12),
              ],
            ),
          ),
          Expanded(child: Container(height: 1, color: AppColors.border)),
        ],
      ),
    );
  }
}
