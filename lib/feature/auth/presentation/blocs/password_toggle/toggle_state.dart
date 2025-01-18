part of 'toggle_bloc.dart';

@immutable
sealed class ToggleState {}

final class ToggleInitial extends ToggleState {
  final bool isObscure;
  ToggleInitial({required this.isObscure});
}
final class TogglePasswordStte extends ToggleState{}