part of 'map_bloc.dart';

@immutable
class MapState {
  final EnumStatus status;
  final String message;

  const MapState({
    this.status = EnumStatus.initial,
    this.message = '',
  });

  MapState copyWith({
    EnumStatus? status,
    String? message,
  }) {
    return MapState(
        status: status ?? this.status,
        message: message ?? this.message
    );
  }
}
