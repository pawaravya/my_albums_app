import 'package:flutter/material.dart';

class AppTextOptions {
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const AppTextOptions({
    this.textColor,
    this.fontSize,
    this.fontWeight,
  });
}

class AppText extends StatelessWidget {
  final AppTextOptions? appTextOptions;
  final String text;

  const AppText({
    super.key,
    this.appTextOptions,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: appTextOptions?.textColor ?? Colors.black,
        fontSize: appTextOptions?.fontSize ?? 14,
        fontWeight: appTextOptions?.fontWeight ?? FontWeight.normal,
      ),
    );
  }
}
