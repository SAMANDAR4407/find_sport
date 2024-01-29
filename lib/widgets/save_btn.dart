import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../translations/locale_keys.g.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xAD00001F), Color(0xFF01001F)],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Center(
          child: Text(
            LocaleKeys.save_btn.tr(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    )
    ;
  }
}
