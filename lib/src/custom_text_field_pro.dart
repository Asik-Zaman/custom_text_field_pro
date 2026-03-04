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
  final EdgeInsetsGeometry? contentPadding;
  final double? bottomDifference;
  final double? height;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final String? initialValue;

  final void Function()? onTap;
  final void Function()? onSuffixTap;
  final void Function()? onPrefixTap;
  final Function(String text)? onChanged;
  final Function(String countryCode)? onCountryCodeChanged;
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
    this.onCountryCodeChanged,
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
    this.contentPadding,
    this.bottomDifference,
    this.height,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.initialValue,
  });

  @override
  State<CustomTextFieldPro> createState() => _CustomTextFieldProState();
}

class _CustomTextFieldProState extends State<CustomTextFieldPro> {
  bool _obscureText = true;
  String? _selectedCountryCode;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _selectedCountryCode = widget.initialCountryCode ?? '+1';
    // Notify parent of initial country code
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onCountryCodeChanged?.call(_selectedCountryCode!);
    });
  }

  @override
  void didUpdateWidget(covariant CustomTextFieldPro oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue &&
        widget.controller == null) {
      _controller.text = widget.initialValue ?? '';
    }
    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller == null) {
        _controller.dispose();
      }
      _controller =
          widget.controller ?? TextEditingController(text: widget.initialValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? const CustomTextFieldTheme();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.titleText != null)
          Padding(
            padding: EdgeInsets.only(bottom: widget.bottomDifference ?? 8),
            child: RichText(
              text: TextSpan(
                text: widget.titleText ?? '',
                style: theme.titleStyle,
                children: [
                  if (widget.isRequiredFill)
                    const TextSpan(
                      text: '*',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          ),
        SizedBox(
          height: widget.height ?? 50,
          child: TextFormField(
            controller: _controller,
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
            style: theme.textStyle,
            decoration: InputDecoration(
              filled: widget.filled,
              fillColor: theme.fillColor,
              labelText: widget.showLabelText ? widget.labelText : null,
              hintText: widget.hintText,
              labelStyle: theme.labelStyle,
              hintStyle: theme.hintStyle,
              errorStyle: theme.errorStyle,
              enabled: widget.isEnabled,
              contentPadding:
                  widget.contentPadding ??
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                borderSide: BorderSide(
                  color: theme.focusedBorderColor,
                  width: 1.2,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: theme.focusedBorderColor,
                  width: 1.2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: theme.errorBorderColor,
                  width: 1.2,
                ),
              ),
              prefixIcon: widget.showCountryCodePicker
                  ? _buildCountryCodePicker(theme)
                  : (widget.prefixIcon != null
                        ? InkWell(
                            splashFactory: NoSplash.splashFactory,
                            onTap: widget.onPrefixTap,
                            child: widget.prefixIcon,
                          )
                        // IconButton(
                        //     icon: widget.prefixIcon!,
                        //     onPressed: widget.onPrefixTap,
                        //   )
                        : null),
              prefixIconConstraints:
                  widget.prefixIconConstraints ??
                  BoxConstraints(
                    minHeight: 10,
                    minWidth: 10,
                    maxHeight: 30,
                    maxWidth: widget.showCountryCodePicker ? 80 : 30,
                  ),
              suffixIcon: _buildSuffixIcon(theme),
              suffixIconConstraints:
                  widget.suffixIconConstraints ??
                  BoxConstraints(
                    minHeight: 10,
                    minWidth: 10,
                    maxHeight: 30,
                    maxWidth: 30,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the suffix icon area
  Widget? _buildSuffixIcon(CustomTextFieldTheme theme) {
    if (widget.isPassword) {
      return Theme(
        data: ThemeData(splashFactory: NoSplash.splashFactory),
        child: InkWell(
          child: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: theme.iconColor,
          ),
          onTap: () => setState(() => _obscureText = !_obscureText),
        ),
      );
    } else if (widget.suffixIcon != null) {
      return InkWell(
        child: widget.suffixIcon!,
        splashFactory: NoSplash.splashFactory,
        onTap: widget.onSuffixTap,
      );
    }
    return null;
  }

  /// Builds the country code picker widget
  Widget _buildCountryCodePicker(CustomTextFieldTheme theme) {
    return InkWell(
      onTap: () => _showCountryPicker(theme),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        constraints: const BoxConstraints(minWidth: 60, maxWidth: 80),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                _selectedCountryCode ?? '+1',
                style: TextStyle(
                  color: theme.iconColor,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.arrow_drop_down, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  /// Displays the actual country picker modal
  void _showCountryPicker(CustomTextFieldTheme theme) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      moveAlongWithKeyboard: true,
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: theme.bottomSheetHeight,
        borderRadius: BorderRadius.circular(theme.pickerRadius!),
        textStyle: theme.textStyle,
        searchTextStyle: theme.textStyle,
        inputDecoration: theme.pickerDecoration,
      ),
      onSelect: (Country country) {
        setState(() {
          _selectedCountryCode = '+${country.phoneCode}';
        });
        // Notify parent of country code change
        widget.onCountryCodeChanged?.call(_selectedCountryCode!);
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

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
