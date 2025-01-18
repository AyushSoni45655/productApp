import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:products_application/auth_service/authservice.dart';
import 'package:products_application/feature/auth/data/datasource/productrepo_implementation.dart';
import 'package:products_application/feature/auth/data/datasource/shared_preferenc_products.dart';
import 'package:products_application/feature/auth/domain/repositry/product_repositry.dart';
import 'package:products_application/feature/auth/domain/usecase/add_product_use_case.dart';
import 'package:products_application/feature/auth/domain/usecase/filter_product_use_case.dart';
import 'package:products_application/feature/auth/domain/usecase/get_product.dart';
import 'package:products_application/feature/auth/domain/usecase/product_delete.dart';
import 'package:products_application/feature/auth/presentation/blocs/authentication/login_bloc.dart';
import 'package:products_application/feature/auth/presentation/blocs/password_toggle/toggle_bloc.dart';
import 'package:products_application/feature/auth/presentation/blocs/product/products_bloc.dart';
import 'package:products_application/feature/auth/presentation/screens/auth_screen/add_product.dart';
import 'package:products_application/feature/auth/presentation/screens/auth_screen/home.dart';
import 'package:products_application/feature/auth/presentation/screens/auth_screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/theme.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
 final prefs = await SharedPreferences.getInstance();
 final locatlData = SharedPreferenceDataSource(prefs: prefs);
 final repo = ProductRepoImpl(sharedPreferenceDataSource: locatlData);
  final isLoggedIN = await AuthService.isLoggedIn();
  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductsBloc(
                addProductUseCase: AddProductUseCase(productRepositry: repo),
                filterProductUseCase: FilterProductUseCase(productRepositry: repo),
                getProductUseCase: GetProductUseCase(productRepositry: repo),
                produtDeleteUseCase: ProdutDeleteUseCase(productRepositry: repo)
            )..add(getProductEvent()),),
            BlocProvider(create: (context) => LoginBloc(),),
            BlocProvider(create: (context) => ToggleBloc(),),

          ],
          child: MyApp(isLoggedIn: isLoggedIN,)));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key,required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 890),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: ThemeMode.system,
          darkTheme: AAppTheme.darkTheme,
          theme: AAppTheme.lightTheme,
          initialRoute: isLoggedIn?'/home' : "/",
          routes: {
            "/": (context)=> LoginScreen(),
            '/home':(context)=>HomeScreen(),
            '/addProduct':(context)=>AddProductScreen(),
          },
          //close this is
        );
      },
    );
  }
}

// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthblocBloc, AuthblocState>(
//       listener: (context, state) {
//         if (state is AuthAuthenticated) {
//           // User is authenticated, navigate to HomeScreen
//           Navigator.pushReplacementNamed(context, '/home');
//         } else if (state is AuthblocInitial) {
//           // User is not authenticated, stay on LoginScreen
//           Navigator.pushReplacementNamed(context, '/');
//         }
//       },
//       child: BlocBuilder<AuthblocBloc, AuthblocState>(
//         builder: (context, state) {
//           if (state is AuthLoading) {
//             return Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           } else if (state is AuthblocInitial) {
//             return LoginScreen(); // If not authenticated, show LoginScreen
//           } else if (state is AuthError) {
//             return Scaffold(
//               body: Center(child: Text("Error: ${state.error}")),
//             );
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }