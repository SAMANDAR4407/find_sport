import 'package:easy_localization/easy_localization.dart';
import 'package:find_sport/models/user.dart';
import 'package:find_sport/pages/map_page.dart';
import 'package:find_sport/translations/locale_keys.g.dart';
import 'package:find_sport/widgets/custom_text_field.dart';
import 'package:find_sport/widgets/save_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../bloc/sign_up/sign_up_bloc.dart';
import '../widgets/mask_input_formatter.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var maskFormatter = MaskTextInputFormatter(mask: '+### ## ### ## ##', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            return Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Image.asset('assets/images/img2.png'),
              ),
              Text(
                LocaleKeys.sign_up_title.tr(),
                style: const TextStyle(
                  color: Color(0xFF01001F),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                title: LocaleKeys.first_name.tr(),
                hint: LocaleKeys.first_name_hint.tr(),
                controller: firstnameController,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                title: LocaleKeys.last_name.tr(),
                hint: LocaleKeys.last_name_hint.tr(),
                controller: lastnameController,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                title: LocaleKeys.phone.tr(),
                hint: '+998',
                controller: phoneController,
                formatters: [maskFormatter],
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                title: LocaleKeys.password.tr(),
                hint: LocaleKeys.password_hint.tr(),
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                title: LocaleKeys.confirm_password.tr(),
                hint: LocaleKeys.confirm_password_hint.tr(),
                obscureText: true,
                onEditingComplete: () {
                  if (passwordController.text != confirmPasswordController.text) {
                    Fluttertoast.showToast(msg: LocaleKeys.toast_mismatch.tr());
                  } else if (firstnameController.text.isEmpty || lastnameController.text.isEmpty || phoneController.text.isEmpty) {
                    Fluttertoast.showToast(msg: LocaleKeys.toast_fill_fields.tr());
                  } else {
                    isEnabled = true;
                    FocusScope.of(context).unfocus();
                  }
                },
                controller: confirmPasswordController,
                action: TextInputAction.done,
              ),
              const SizedBox(height: 20),
              Builder(
                builder: (context) {
                  if (state.status == EnumStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    );
                  }
                  if (state.status == EnumStatus.fail) {
                    Fluttertoast.showToast(msg: state.message);
                  }
                  if(state.status == EnumStatus.success){
                    Fluttertoast.showToast(msg: LocaleKeys.toast_register_success.tr());
                    BlocProvider.of<SignUpBloc>(context).add(Navigate(context: context));
                  }
                  return SaveButton(onTap: !isEnabled
                      ? (){
                    if(passwordController.text != confirmPasswordController.text){
                      Fluttertoast.showToast(msg: LocaleKeys.toast_mismatch.tr());
                      return;
                    }
                    Fluttertoast.showToast(msg: LocaleKeys.toast_fill_fields.tr());
                  }
                      : () {
                      final user = User(
                      firstname: firstnameController.text,
                      lastname: lastnameController.text,
                      phone: phoneController.text.replaceAll(' ', ''),
                      password: confirmPasswordController.text,
                    );

                      // Navigator.push(context, CupertinoPageRoute(builder: (context) => const MapPage()));
                    BlocProvider.of<SignUpBloc>(context).add(PostRequest(user: user));
                  });
                }
              )
            ]);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
