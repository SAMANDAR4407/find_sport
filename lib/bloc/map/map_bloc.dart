import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:find_sport/models/address.dart';
import 'package:find_sport/translations/locale_keys.g.dart';
import 'package:meta/meta.dart';

import '../../core/api_service.dart';
import '../sign_up/sign_up_bloc.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  ApiClient client;

  MapBloc({required this.client}) : super(const MapState()) {
    on<MapEvent>((event, emit) async {
      switch(event) {
        case PostAddress():
          await _onPostRequest(event, emit);
      }
    });
  }

  Future<void> _onPostRequest(PostAddress event, Emitter<MapState> emit) async {
    if(state.status == EnumStatus.loading) return;
    emit(state.copyWith(status: EnumStatus.loading));
    try{
      await client.addLocation(event.address);
      emit(state.copyWith(status: EnumStatus.success, message: LocaleKeys.toast_register_success.tr()));
    } catch(e){
      emit(state.copyWith(message: LocaleKeys.toast_register_fail.tr(), status: EnumStatus.fail));
    }
  }
}
