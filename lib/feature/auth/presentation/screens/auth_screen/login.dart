import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:products_application/core/constant/colorsHelper.dart';
import 'package:products_application/core/constant/dimensionHelper.dart';
import 'package:products_application/core/constant/fontsHelper.dart';
import 'package:products_application/core/constant/stringHelper.dart';
import 'package:products_application/core/constant/validation.dart';
import 'package:products_application/core/utils/utility.dart';
import 'package:products_application/feature/auth/presentation/blocs/authentication/login_bloc.dart';
import 'package:products_application/feature/auth/presentation/blocs/password_toggle/toggle_bloc.dart';
import 'package:products_application/feature/auth/presentation/widgets/custom_button.dart';
import 'package:products_application/feature/auth/presentation/widgets/custom_text.dart';
import 'package:products_application/feature/auth/presentation/widgets/custom_textfield.dart';

import '../../../../../core/constant/assetsHelper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mailCon = TextEditingController();
  final TextEditingController passwordCon = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
  listener: (context, state) {
    if(state is LoginError){
      Utils().toastMessage(state.error.toString());
    }
    else if(state is LoginSuccess){
      Utils().toastMessage(state.token);
      Navigator.pushNamed(context, '/home');
    }
  },
  builder: (context, state) {
    if(state is LoginLoading){
      return Center(child: CircularProgressIndicator(color: Colors.green,),);
    }
    return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(DimensionHelper.dimens_15.sp),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  height: DimensionHelper.dimens_300.h,
                  width: DimensionHelper.dimens_all,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(AssetsHelper.login))),
                ),
                SizedBox(height: DimensionHelper.dimens_50,),
                CustomText(
                  title: StringHelper.login,
                  alignment: Alignment.centerLeft,
                  color: Colors.black,
                  fontSize: FontHelper.font_34,
                ),
                SizedBox(height: DimensionHelper.dimens_20.h,),
                CustomTextField(
                  controller: mailCon,
                  hintText: StringHelper.eHint,
                  levelText: StringHelper.eLevel,
                  validatore: (value) {
                    return AValidator.validateEmail(value);
                  },
                  hide: false,
                  inputType: TextInputType.emailAddress,
                  prefixIcon: Icons.mail,
                ),
                SizedBox(
                  height: DimensionHelper.dimens_20.h,
                ),
                BlocBuilder<ToggleBloc, ToggleInitial>(
                  builder: (context, state) {
                  return CustomTextField(
                    controller: passwordCon,
                    hintText: StringHelper.pHint,
                    levelText: StringHelper.pLevel,
                    validatore: (value) {
                      return AValidator.validatePassword(value);
                    },
                    hide: state.isObscure,
                    inputType: TextInputType.visiblePassword,
                    prefixIcon: Icons.password,
                     suffixIcon: IconButton(onPressed: (){
                       context.read<ToggleBloc>().add(TogglePasswordEvnt());
                     }, icon: Icon(state.isObscure?Iconsax.eye_slash:Iconsax.eye)),
                  );}
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        StringHelper.fP,
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
                ),
                SizedBox(
                  height: DimensionHelper.dimens_20.h,
                ),
                CustomButton(title: StringHelper.login,text: StringHelper.login,callback: () {
                  if(formKey.currentState!.validate()){
                    context.read<LoginBloc>().add(LoginTapEvent(email: mailCon.text.trim(), password: passwordCon.text.trim()));
                  }
                },),
                SizedBox(height: DimensionHelper.dimens_30.h,),
                CustomText(title: "Or",color: Colors.grey,),
                SizedBox(height: DimensionHelper.dimens_20.h,),
                CustomButton(title: StringHelper.google,socialBool: true,),
                SizedBox(height: DimensionHelper.dimens_20.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(title: StringHelper.dA),
                    CustomText(title: StringHelper.register,color: ColorsHelper.nBlue,)
                  ],
                )
              ],
            ),
          ),
        ),
      );
  },
),
    );
  }
}
