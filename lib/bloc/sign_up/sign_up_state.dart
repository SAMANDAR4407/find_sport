part of 'sign_up_bloc.dart';

@immutable
class SignUpState {
  final EnumStatus status;
  final String message;

  const SignUpState({
    this.status = EnumStatus.initial,
    this.message = ''
  });

  SignUpState copyWith({
    EnumStatus? status,
    String? message,
  }) {
    return SignUpState(
      status: status ?? this.status,
      message: message ?? this.message
    );
  }

}

enum EnumStatus{ loading, initial, success, fail }