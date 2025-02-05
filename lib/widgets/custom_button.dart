import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.fixedSize,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final Size? fixedSize;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        fixedSize: fixedSize,
        backgroundColor: isPrimary
            ? theme.colorScheme.primary
            : theme.colorScheme.primary.withAlpha((0.2 * 255).round()),
        foregroundColor:
            isPrimary ? theme.colorScheme.onPrimary : theme.colorScheme.primary,
      ),
      child: Text(text),
    );
  }
}
