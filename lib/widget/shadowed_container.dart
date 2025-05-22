import 'package:flutter/material.dart';

class ShadowedContainer extends StatelessWidget {
  final Widget child;

  const ShadowedContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0x99e6e6fa),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1.0,
              blurRadius: 10.0,
              offset: Offset(5, 5),
            )
          ]
      ),
      child: child,
    );
  }
}