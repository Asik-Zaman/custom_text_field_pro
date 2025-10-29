import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'custom_text_field_theme.dart';

class CustomTextFieldPro extends StatefulWidget {
  final String? hintText;
  final String? titleText;
  final String? labelText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final bool isAmount;
  final bool isRequiredFill;
  final bool readOnly;
  final bool filled;
  final bool showBorder;
  final bool showLabelText;
  final bool isEnabled;
  final bool showCountryCodePicker;
  final String? initialCountryCode;

  final void Function()? onTap;
  final void Function()? onSuffixTap;
  final void Function()? onPrefixTap;
  final Function(String text)? onChanged;
  final String? Function(String?)? validator;

  final int maxLines;
  final TextCapitalization capitalization;
  final double borderRadius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double suffixIconSize;
  final List<TextInputFormatter>? inputFormatters;
  final CustomTextFieldTheme? theme;

  const CustomTextFieldPro({
    super.key,
    this.hintText,
    this.titleText,
    this.labelText,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.onTap,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onPrefixTap,
    this.onSuffixTap,
    this.inputFormatters,
    this.theme,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.capitalization = TextCapitalization.none,
    this.readOnly = false,
    this.isPassword = false,
    this.isAmount = false,
    this.isEnabled = true,
    this.isRequiredFill = false,
    this.showBorder = true,
    this.showLabelText = true,
    this.filled = true,
    this.borderRadius = 8,
    this.suffixIconSize = 18,
    this.showCountryCodePicker = false,
    this.initialCountryCode,
  });

  @override
  State<CustomTextFieldPro> createState() => _CustomTextFieldProState();
}

class _CustomTextFieldProState extends State<CustomTextFieldPro> {
  bool _obscureText = true;
  String? _selectedCountryCode;

  @override
  void initState() {
    super.initState();
    _selectedCountryCode = widget.initialCountryCode ?? '+1';
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? const CustomTextFieldTheme();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.titleText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: RichText(
              text: TextSpan(
                text: widget.titleText ?? '',
                style: TextStyle(
                  color: theme.titleColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  if (widget.isRequiredFill)
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          ),
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: widget.inputType,
          textInputAction: widget.inputAction,
          obscureText: widget.isPassword ? _obscureText : false,
          textCapitalization: widget.capitalization,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          onChanged: widget.onChanged,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: _getInputFormatters(),
          onFieldSubmitted: (_) {
            if (widget.nextFocus != null) {
              FocusScope.of(context).requestFocus(widget.nextFocus);
            }
          },
          decoration: InputDecoration(
            filled: widget.filled,
            fillColor: theme.fillColor,
            labelText: widget.showLabelText ? widget.labelText : null,
            hintText: widget.hintText,
            labelStyle: theme.labelStyle,
            hintStyle: theme.hintStyle,
            enabled: widget.isEnabled,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(color: theme.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(color: theme.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(color: theme.focusedBorderColor, width: 1.2),
            ),
            prefixIcon: widget.showCountryCodePicker
                ? _buildCountryCodePicker(theme)
                : (widget.prefixIcon != null
                    ? IconButton(
                        icon: widget.prefixIcon!,
                        onPressed: widget.onPrefixTap,
                      )
                    : null),
            suffixIcon: _buildSuffixIcon(theme),
          ),
        ),
      ],
    );
  }

  /// Builds the suffix icon area
  Widget? _buildSuffixIcon(CustomTextFieldTheme theme) {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: theme.iconColor,
        ),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      );
    } else if (widget.suffixIcon != null) {
      return IconButton(
        icon: widget.suffixIcon!,
        onPressed: widget.onSuffixTap,
      );
    }
    return null;
  }

  /// Builds the country code picker widget
  Widget _buildCountryCodePicker(CustomTextFieldTheme theme) {
    return InkWell(
      onTap: _showCountryPicker,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _selectedCountryCode ?? '+1',
              style: TextStyle(
                color: theme.iconColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(Icons.arrow_drop_down, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  /// Displays the actual country picker modal
  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          _selectedCountryCode = '+${country.phoneCode}';
        });
      },
    );
  }

  /// Input filters for numeric or amount fields
  List<TextInputFormatter>? _getInputFormatters() {
    if (widget.inputType == TextInputType.phone) {
      return [FilteringTextInputFormatter.allow(RegExp(r'[0-9+]'))];
    } else if (widget.isAmount) {
      return [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))];
    }
    return widget.inputFormatters;
  }
}