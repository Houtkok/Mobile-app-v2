import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

class BlaButton extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final IconData? icon;
  final VoidCallback? onPressed;

  const BlaButton({
    super.key,
    required this.text,
    required this.isPrimary,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: isPrimary ? BlaColors.primary : BlaColors.white,
        borderRadius: BorderRadius.circular(25),
        border: isPrimary ? null : Border.all(color: BlaColors.backgroundAccent, width: 3),
      ),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: isPrimary ? Colors.white : BlaColors.primary),
        label: Text(
          text,
          style: BlaTextStyles.label.copyWith(color: isPrimary ? BlaColors.white : BlaColors.primary),
        ),
      ),
    );
  }
}