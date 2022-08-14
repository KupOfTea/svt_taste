import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;
  final Alignment alignment;
  final String ellipsis;

  const GradientText(
    this.text,
    this.gradient, {
    this.style = const TextStyle(),
    this.alignment = Alignment.centerLeft,
    this.ellipsis = '\u2026',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: text,
          style: style,
        ),
        ellipsis: ellipsis,
      );
      textPainter.layout(
        maxWidth: constraints.maxWidth,
      );
      final bounded =
          constraints.hasBoundedHeight && constraints.hasBoundedWidth;
      final size = bounded ? constraints.biggest : textPainter.size;
      // print('constraints.biggest: ${constraints.biggest},
      // textPainter.size: ${textPainter.size}');
      // print('incoming constraints are ${bounded? "" : "NOT "}bounded,
      // using ${bounded? "constraint\'s" : "text"} size: $size');

      return CustomPaint(
        painter: _GradientTextPainter(
          text: text,
          style: style,
          gradient: gradient,
          textPainter: textPainter,
          alignment: alignment,
        ),
        size: size,
      );
    });
  }
}

class _GradientTextPainter extends CustomPainter {
  final Gradient gradient;
  final String text;
  final TextStyle style;
  final TextPainter textPainter;
  final Alignment alignment;

  _GradientTextPainter({
    Listenable? repaint,
    required this.text,
    required this.style,
    required this.gradient,
    required this.textPainter,
    required this.alignment,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    final textSpanRect =
        alignment.inscribe(textPainter.size, Offset.zero & size);
    // print('=== $size * $alignment => $textSpanRect');

    if (debugPaintSizeEnabled)
      debugPaintPadding(canvas, textSpanRect, textSpanRect.deflate(2));

    textPainter.text = TextSpan(
      text: text,
      style: style.copyWith(
        foreground: Paint()..shader = gradient.createShader(textSpanRect),
      ),
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    textPainter.paint(canvas, textSpanRect.topLeft);
  }

  @override
  bool shouldRepaint(_GradientTextPainter oldDelegate) {
    return gradient != oldDelegate.gradient ||
        text != oldDelegate.text ||
        style != oldDelegate.style;
  }
}
