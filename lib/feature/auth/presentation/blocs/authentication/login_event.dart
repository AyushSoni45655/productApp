part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}
class LoginTapEvent extends LoginEvent{
  final String email;
  final String password;
  LoginTapEvent({required this.email,required this.password});
}
class LogOutEvent extends LoginEvent{}