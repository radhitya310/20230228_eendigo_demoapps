import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredOval extends StatelessWidget {
  final double width;
  final double height;
  final Color borderColor;
  final double borderWidth;


  BlurredOval({
    required this.width,
    required this.height,
    required this.borderColor,
    required this.borderWidth
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            //shape: BoxShape.circle,
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
            borderRadius: const BorderRadius.vertical(
                  bottom: Radius.elliptical(100, 150),
                ),
          ),
        ),
      ],
    );
  }
}