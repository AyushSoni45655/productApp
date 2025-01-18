import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'toggle_event.dart';
part 'toggle_state.dart';

class ToggleBloc extends Bloc<ToggleEvent, ToggleInitial> {
  ToggleBloc() : super(ToggleInitial(isObscure: true)) {
    on<TogglePasswordEvnt>((event, emit) {
      emit(ToggleInitial(isObscure: !state.isObscure));
    });
  }
}
