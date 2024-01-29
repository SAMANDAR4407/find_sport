part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class PostRequest extends SignUpEvent {
    final User user;

  PostRequest({required this.user});
}

class Navigate extends SignUpEvent {
  final BuildContext context;

  Navigate({required this.context});
}
