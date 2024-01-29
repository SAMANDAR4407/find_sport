import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_sport/core/api_service.dart';
import 'package:find_sport/models/user.dart';
import 'package:find_sport/translations/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../pages/map_page.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  ApiClient client;

  SignUpBloc({required this.client}) : super(const SignUpState()) {
    on<SignUpEvent>((event, emit) async {
      switch(event){
        case PostRequest():
          await _onPostRequest(event, emit);
        case Navigate():
          await _onNavigate(event, emit);
      }
    });
  }

  Future<void> _onPostRequest(PostRequest event, Emitter<SignUpState> emit) async {
    if(state.status == EnumStatus.loading) return;
    emit(state.copyWith(status: EnumStatus.loading));
    try{
      final response = await client.registerUser(event.user);
      emit(state.copyWith(status: EnumStatus.success, message: response.message));
    } catch(e){
      emit(state.copyWith(message: LocaleKeys.toast_register_fail.tr(), status: EnumStatus.fail));
    }
  }

  Future<void> _onNavigate(Navigate event, Emitter<SignUpState> emit) async {
    try{
      Navigator.push(event.context, CupertinoPageRoute(builder: (context) => const MapPage()));
    } catch(e){
      debugPrint(e.toString());
    }
  }
}
