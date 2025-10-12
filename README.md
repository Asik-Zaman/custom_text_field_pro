# 🌟 Custom Text Field Pro

![Pub Version](https://img.shields.io/pub/v/custom_text_field_pro)
![License](https://img.shields.io/badge/license-MIT-blue)

A Flutter package that provides **highly customizable text fields** with built-in support for password visibility, prefix/suffix icons, and even a **country code picker** — all with global theming control.

---

## 📦 Installation

### 🔗 Depend on it

Run this command:

With Flutter:

```bash
flutter pub add custom_text_field_pro
````

Or add it manually to your **pubspec.yaml**:

```yaml
dependencies:
  custom_text_field_pro: ^0.1.0
```

Then run:

```bash
flutter pub get
```

---

## 🎨 Why Custom Text Field Pro?

This widget eliminates repetitive `TextFormField` styling code and gives you a **beautiful, flexible input component** with features like:

✅ Password toggle visibility
✅ Custom icons and colors
✅ Built-in country code picker
✅ Global theming
✅ Focused and unfocused border control
✅ Reusable across your entire app

---

## ⚙️ Setup Example

```dart
import 'package:flutter/material.dart';
import 'package:custom_text_field_pro/custom_text_field_pro.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final customTheme = const CustomTextFieldTheme(
      borderColor: Colors.grey,
      focusedBorderColor: Colors.blue,
      fillColor: Color(0xFFF7F9FB),
      iconColor: Colors.deepPurple,
      titleColor: Color(0xFF202532),
    );

    return MaterialApp(
      title: 'Custom Text Field Pro Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('CustomTextFieldPro Example')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomTextFieldPro(
                titleText: "Username",
                hintText: "Enter your username",
                theme: customTheme,
              ),
              const SizedBox(height: 16),
              CustomTextFieldPro(
                titleText: "Password",
                hintText: "Enter your password",
                isPassword: true,
                theme: customTheme.copyWith(
                  focusedBorderColor: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 16),
              CustomTextFieldPro(
                titleText: "Phone Number",
                hintText: "Enter your phone number",
                showCountryCodePicker: true,
                initialCountryCode: '+880',
                inputType: TextInputType.phone,
                theme: customTheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 🎯 Key Features

| Feature | Description |
| --- | --- |
| **🔐 Password Mode** | Toggle visibility for secure inputs |
| **📱 Country Picker** | Optional dropdown for phone fields |
| **🎨 Custom Theme** | Control all colors globally |
| **✨ Icons** | Add prefix & suffix icons easily |
| **🧩 Reusable** | Consistent design across app |

---

## 🧱 Theme Customization

Create your global theme once:

```dart
const customTheme = CustomTextFieldTheme(
  borderColor: Colors.grey,
  focusedBorderColor: Colors.blue,
  fillColor: Colors.white,
  iconColor: Colors.deepPurple,
  titleColor: Colors.black,
);
```

Then reuse or override anywhere:

```dart
theme: customTheme.copyWith(
  focusedBorderColor: Colors.green,
  iconColor: Colors.green,
),
```

---

## 💡 Suffix & Prefix Examples

```dart
CustomTextFieldPro(
  titleText: "Email",
  hintText: "example@gmail.com",
  prefixIcon: Icons.email_outlined,
  suffixIcon: Icons.check_circle_outline,
  theme: customTheme,
);
```

### 📞 With Country Code Picker

```dart
CustomTextFieldPro(
  titleText: "Phone",
  hintText: "Enter your phone number",
  showCountryCodePicker: true,
  initialCountryCode: '+1',
  theme: customTheme,
);
```

---

## 🧠 Tip: Make it Global

You can create your theme in a separate Dart file, for example:

```dart
// theme/custom_text_field_theme.dart
import 'package:custom_text_field_pro/custom_text_field_pro.dart';
import 'package:flutter/material.dart';

const customTextFieldTheme = CustomTextFieldTheme(
  borderColor: Colors.grey,
  focusedBorderColor: Colors.blue,
  fillColor: Color(0xFFF7F9FB),
  iconColor: Colors.deepPurple,
  titleColor: Color(0xFF202532),
);
```

Then use anywhere:

```dart
import 'theme/custom_text_field_theme.dart';

CustomTextFieldPro(
  titleText: "Password",
  hintText: "Enter password",
  isPassword: true,
  theme: customTextFieldTheme,
);
```

---

## 🧩 Parameters Overview

| Parameter | Type | Description |
| --- | --- | --- |
| `titleText` | `String` | Optional title text above input |
| `labelText` | `String` | Label for text field |
| `hintText` | `String` | Placeholder text |
| `isPassword` | `bool` | Enables password toggle |
| `prefixIcon` | `IconData` | Icon before text |
| `suffixIcon` | `IconData` | Icon after text |
| `onSuffixTap` | `VoidCallback` | Callback on suffix tap |
| `showCountryCodePicker` | `bool` | Enables country picker |
| `initialCountryCode` | `String` | Default country code |
| `theme` | `CustomTextFieldTheme` | Global color & style config |


## 🚨 Troubleshooting

### 🔹 "No country picker showing?"

Ensure you have imported the required picker dependency if used.

### 🔹 "Theme not applying?"

Check that you passed `theme: customTheme` to the widget.

---

## 📜 License

MIT - See [LICENSE](https://chatgpt.com/c/LICENSE) for details.

Made with ❤️ by Md. Asikuzzaman
GitHub: https://github.com/Asik-Zaman

