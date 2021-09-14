import 'package:flutter/material.dart';
import 'package:m_whm/constants/color.dart';

class KTextField extends StatelessWidget {
  const KTextField({
    this.obscure = false,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.placeholder,
    this.maxLines = 1,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.error = false,
    this.controller,
  });

  final Function onChanged;
  final bool obscure;
  final String label;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final String placeholder;
  final int maxLines;
  final TextInputType keyboardType;
  final String errorText;
  final bool error;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Container(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  label,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            : Container(),
        label != null
            ? SizedBox(
                height: 12.0,
              )
            : Container(),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: TextStyle(fontSize: 18.0),
          obscureText: obscure,
          textAlignVertical: TextAlignVertical.center,
          maxLines: maxLines,
          decoration: InputDecoration(
            errorText: errorText,
            errorBorder: error
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: BaseColors.error, width: 1.0),
                  )
                : null,
            hintText: placeholder,
            hintStyle: TextStyle(color: BaseColors.placeholder),
            filled: true,
            fillColor: Color(0xFFF3F3F3),
            contentPadding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: prefixIcon,
            ),
            suffixIcon: suffixIcon,
            prefixIconConstraints:
                BoxConstraints(minWidth: 25, maxHeight: 25.0),
            border: new OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
