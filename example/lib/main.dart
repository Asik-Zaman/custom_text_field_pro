import 'package:flutter/material.dart';
import 'package:custom_text_field_pro/custom_text_field_pro.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Text Field Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Base theme
    final customTheme = const CustomTextFieldTheme(
      borderColor: Colors.grey,
      focusedBorderColor: Colors.blue,
      fillColor: Color(0xFFF7F9FB),
      iconColor: Colors.deepPurple,
      titleColor: Color(0xFF202532),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomTextFieldPro Example'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Username field
            CustomTextFieldPro(
              titleText: "Username",
              labelText: "Username",
              hintText: "Enter your username",
              controller: usernameController,
              isRequiredFill: true,
              theme: customTheme,
            ),
            const SizedBox(height: 20),

            // Password field
            CustomTextFieldPro(
              titleText: "Password",
              labelText: "Password",
              hintText: "Enter your password",
              controller: passwordController,
              isPassword: true,
              isRequiredFill: true,
              theme: customTheme.copyWith(
                focusedBorderColor: Colors.deepPurple,
                iconColor: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 30),

            // Submit button
            ElevatedButton(
              onPressed: () {
                final username = usernameController.text.trim();
                final password = passwordController.text.trim();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text("Username: $username\nPassword: $password"),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
