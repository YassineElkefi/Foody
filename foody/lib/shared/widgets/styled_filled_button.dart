import 'package:flutter/material.dart';
import 'package:foody/theme.dart';

class StyledFilledButton extends StatelessWidget {
  const StyledFilledButton({
    super.key,
    required this.onPressed,
    required this.child
    });

  final Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: child,
          ),
        ),
      );
  }
}