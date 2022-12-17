import 'package:flutter/material.dart';

import '../../constant.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType textInputType;

  // Container(
  //                 width: MediaQuery.of(context).size.width,
  //                 margin: const EdgeInsets.symmetric(horizontal: 20),
  //                 child: TextInputField(
  //                   controller: _ph_noController,
  //                   labelText: 'Phone',
  //                   icon: Icons.phone,
  //                  // isObscure: true,
  //                 ),
  //               ),

  TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    this.suffixIcon,
    this.prefixIcon,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: Divider.createBorderSide(context),
    );

    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Color(0xffD9D9D9),
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefixIconColor: buttonColor,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final IconData icon;

  const TextInputField(
      {Key? key,
      required this.controller,
      required this.labelText,
      this.isObscure = false,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        labelStyle: const TextStyle(
          fontSize: 30,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: borderColor,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: borderColor,
            )),
      ),
      obscureText: isObscure,
    );
  }
}
