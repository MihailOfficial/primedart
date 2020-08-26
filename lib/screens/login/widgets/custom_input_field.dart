import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



import '../../../constants.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final IconData prefixIcon;
  final bool obscureText;

  const CustomInputField({
    @required this.label,
    @required this.prefixIcon,
    this.obscureText = false,
  })  : assert(label != null),
        assert(prefixIcon != null);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(kPaddingM),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        hintText: label,
        hintStyle: TextStyle(
          color: kBlack.withOpacity(0.7),
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: kBlack.withOpacity(0.7),
        ),
      ),
      obscureText: obscureText,
    );
  }
}
