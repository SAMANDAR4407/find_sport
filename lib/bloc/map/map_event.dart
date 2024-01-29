part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class PostAddress extends MapEvent{
  final Address address;

  PostAddress({required this.address});
}
