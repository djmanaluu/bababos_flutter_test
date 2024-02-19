import 'package:bababos_test/commons/ui/base_colors.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final Color? textColor;
  final Function() onTapped;
  final bool isEnabled;

  const BaseButton({
    super.key,
    required this.title,
    required this.onTapped,
    this.backgroundColor,
    this.textColor,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onTapped : null,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 16.0,
        ),
        decoration: BoxDecoration(
          color: isEnabled
              ? backgroundColor ?? BaseColors.darkGrey
              : BaseColors.buttonGrey,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isEnabled
                ? textColor ?? Colors.white
                : BaseColors.mediumLightGrey,
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
