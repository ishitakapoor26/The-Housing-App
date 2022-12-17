import 'package:flutter/material.dart';


class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    Key? key,
    required TextEditingController controller,
    required String hintTtext,
    required bool obscureText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    required String? Function(String?) validator,
  })  : _controller = controller,
        _text = hintTtext,
        _validator = validator,
        _obscureText = obscureText,
        _prefixIcon = prefixIcon,
        _suffixIcon = suffixIcon,
        super(key: key);

  final TextEditingController _controller;
  final String _text;
  final bool _obscureText;
  final Widget? _prefixIcon;
  final Widget? _suffixIcon;
  final String? Function(String?) _validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: _validator,
      obscureText: _obscureText,
      controller: _controller,
      decoration: InputDecoration(
          hintText: _text,
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          prefixIcon: _prefixIcon,
          suffixIcon: _suffixIcon),
    );
  }
}
