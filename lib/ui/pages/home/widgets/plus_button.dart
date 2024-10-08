import 'package:auto_depura/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget {
  final Function() onPressed;
  final Color? color;
  const PlusButton({super.key, required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color ?? AppColors.accent,
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}
