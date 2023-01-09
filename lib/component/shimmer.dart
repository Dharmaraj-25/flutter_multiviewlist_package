import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomWidget extends StatelessWidget {

  final double width;
  final double height;
  const CustomWidget.rectangular({
    this.width = double.infinity,
    required this.height
  });

  @override
  Widget build(BuildContext context)  => Shimmer.fromColors(
    baseColor: Colors.white70,
    highlightColor: Colors.grey[300]!,
    period: const Duration(seconds: 3),
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.grey[300]!,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8)
      ),
    ),
  );
}