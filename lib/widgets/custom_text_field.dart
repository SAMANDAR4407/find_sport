
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.title, required this.hint, required this.controller, this.action = TextInputAction.next, this.formatters, this.keyboardType, this.obscureText=false, this.onEditingComplete});
  final String title;
  final String hint;
  final TextEditingController controller;
  final TextInputAction action;
  final List<TextInputFormatter>? formatters;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15))],
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 45,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            textInputAction: action,
            onTapOutside: (_) {
              FocusScope.of(context).unfocus();
            },
            onEditingComplete: onEditingComplete,
            textCapitalization: TextCapitalization.sentences,
            inputFormatters: formatters,
            maxLines: 1,
            obscureText: obscureText,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
              isDense: true,
              fillColor: Colors.grey.shade400,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    );
  }
}
