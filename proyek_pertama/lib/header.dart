import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.text, required this.padding});

  final String text;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        'Available Balance',
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: const Color(0xFF606A85),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
