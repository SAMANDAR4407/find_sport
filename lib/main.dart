import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_sport/bloc/map/map_bloc.dart';
import 'package:find_sport/core/api_service.dart';
import 'package:find_sport/pages/language_page.dart';
import 'package:find_sport/translations/codegen_loader.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'bloc/sign_up/sign_up_bloc.dart';

void main() async {
  AndroidYandexMap.useAndroidViewSurface = false;
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
      EasyLocalization(
          supportedLocales: [
            Locale(LocaleEnum.uz.code),
            Locale(LocaleEnum.sr.code),
            Locale(LocaleEnum.ru.code),
          ],
          path: 'assets/translations',
          fallbackLocale: Locale(LocaleEnum.uz.code),
          assetLoader: const CodegenLoader(),
          child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final dio = Dio(
      BaseOptions(
        headers: {
          "Content-Type" : "application/json",
          "Accept" : "application/json"
        }
      )
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpBloc(client: ApiClient(dio, baseUrl: 'https://qutb.uz/api'))),
        BlocProvider(create: (context) => MapBloc(client: ApiClient(dio, baseUrl: 'https://qutb.uz/api'))),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Task',
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          localizationsDelegates: context.localizationDelegates,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          home: LanguagePage()
      ),
    );
  }
}


enum LocaleEnum {
  uz('uz'),
  sr('sr'),
  ru('ru');
  final String code;

  const LocaleEnum(this.code);
}
