import 'package:firebase_auth_youtube/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:firebase_auth_youtube/screens/auth/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';
import 'blocs/sign_in_bloc/sign_in_bloc.dart';
import 'screens/home1/blocs/get_product_bloc/get_product_bloc.dart';
import 'screens/home1/main_navigation_page.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Firebase Auth',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
              background: Colors.white,
              onBackground: Colors.black,
              primary: Colors.green,
              onPrimary: Colors.black,
              secondary: Color.fromRGBO(244, 143, 177, 1),
              onSecondary: Colors.white,
              tertiary: Color.fromRGBO(255, 204, 128, 1),
              error: Colors.red,
              outline: Color(0xFF424242)),
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SignInBloc(
                      userRepository:
                          context.read<AuthenticationBloc>().userRepository),
                ),
                BlocProvider(
                  create: (context) =>
                      GetProductBloc(FirebaseProductRepo())..add(GetProduct()),
                ),
              ],
              child: const MainNavigationPage(),
            );
          } else {
            // Replace WelcomeScreen with SignInScreen
            return BlocProvider<SignInBloc>(
              create: (context) => SignInBloc(
                  userRepository:
                      context.read<AuthenticationBloc>().userRepository),
              child: const SignInScreen(),
            );
          }
        }));
  }
}
