import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart'as http;
import 'package:products_application/auth_service/authservice.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginTapEvent>((event, emit)async {
      emit(LoginLoading());
      final  url = Uri.parse("https://reqres.in/api/login");
      try{
        final response = await http.post(url,body: {"email":event.email,"password":event.password});
        if(response.statusCode == 200){
          final data = jsonDecode(response.body);
         await AuthService.login(data['token']);
         emit(LoginSuccess(token: data['token']));
        }else{
          final errordata = jsonDecode(response.body);
          emit(LoginError(error: errordata['error']??'Login Failed'));
        }
      }catch(e){
        emit(LoginError(error: "somenthing went wrong try again later${e.toString()}"));
      }
    });
    on<LogOutEvent>((event, emit) async{
      //emit(LoginLoading());
      try{
        await AuthService.logout();
        emit(LoginInitial());
      }catch(e){
        emit(LoginError(error: e.toString()));
      }
    },);
  }
}
