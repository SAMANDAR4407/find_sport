// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:find_sport/pages/signup_page.dart';
import 'package:find_sport/translations/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

class LanguagePage extends StatelessWidget {
  LanguagePage({super.key});

  final controller = TextEditingController();

  List<DropdownMenuEntry> list = [
    DropdownMenuEntry(value: LocaleEnum.uz.code, label: '🇺🇿 O`zbekcha'),
    DropdownMenuEntry(value: LocaleEnum.sr.code, label: '🇺🇿 Ўзбекча'),
    DropdownMenuEntry(value: LocaleEnum.ru.code, label: '🇷🇺 Русский'),
  ];

  var _selectedLocale = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('\t\t\t\t\t\tInterfeys tili', style: TextStyle(fontWeight: FontWeight.w500))],
                  ),
                  const SizedBox(height: 10),
                  DropdownMenu(
                    controller: controller,
                    menuStyle: const MenuStyle(surfaceTintColor: MaterialStatePropertyAll(Colors.white)),
                    dropdownMenuEntries: list,
                    width: 300,
                    hintText: '🇺🇿 Tilni tanlang',
                    onSelected: (value) {
                      _selectedLocale = value;
                      debugPrint(_selectedLocale);
                    },
                  ),
                  const SizedBox(height: 30),
                  Material(
                    borderRadius: BorderRadius.circular(50),
                    clipBehavior: Clip.antiAlias,
                    elevation: 10,
                    color: const Color(0xff01001F),
                    child: InkWell(
                      onTap: (){
                        if (_selectedLocale.isNotEmpty) {
                          context.setLocale(Locale(_selectedLocale));
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => const SignUpPage()));
                        } else {
                          Fluttertoast.showToast(msg: LocaleKeys.toast_choose_lang.tr());
                        }
                      },
                      child: const SizedBox(
                        width: 65,
                        height: 65,
                        child: Center(
                          child: Icon(
                            CupertinoIcons.arrow_right,
                            color: Colors.white,
                          ),
                        )
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }
}
