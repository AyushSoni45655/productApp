part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginLoading extends LoginState{}
final class LoginSuccess extends LoginState{
  final String token;
  LoginSuccess({required this.token});
}
final class LoginError extends LoginState{
  final String error;
  LoginError({required this.error});
}