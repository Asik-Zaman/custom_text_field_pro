// lib/src/custom_text_field_theme.dart
import 'package:flutter/material.dart';

class CustomTextFieldTheme {
  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color fillColor;
  final Color iconColor;
  final Color labelColor;
  final Color hintColor;
  final Color titleColor;
  final double borderRadius;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;

  const CustomTextFieldTheme({
    this.borderColor = const Color(0xFFBFBFBF),
    this.focusedBorderColor = const Color(0xFF2196F3),
    this.errorBorderColor = Colors.red,
    this.fillColor = const Color(0xFFF9F9F9),
    this.iconColor = const Color(0xFF7A7A7A),
    this.labelColor = const Color(0xFF6B6B6B),
    this.hintColor = const Color(0xFF9E9E9E),
    this.titleColor = const Color(0xFF202532),
    this.borderRadius = 8,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
  });

  CustomTextFieldTheme copyWith({
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? fillColor,
    Color? iconColor,
    Color? labelColor,
    Color? hintColor,
    Color? titleColor,
    double? borderRadius,
    TextStyle? textStyle,
    TextStyle? labelStyle,
    TextStyle? hintStyle,
    TextStyle? errorStyle,
  }) {
    return CustomTextFieldTheme(
      borderColor: borderColor ?? this.borderColor,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      fillColor: fillColor ?? this.fillColor,
      iconColor: iconColor ?? this.iconColor,
      labelColor: labelColor ?? this.labelColor,
      hintColor: hintColor ?? this.hintColor,
      titleColor: titleColor ?? this.titleColor,
      borderRadius: borderRadius ?? this.borderRadius,
      textStyle: textStyle ?? this.textStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      errorStyle: errorStyle ?? this.errorStyle,
    );
  }
}