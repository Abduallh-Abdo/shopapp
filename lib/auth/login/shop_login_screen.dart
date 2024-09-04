import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/auth/login/login_cubit/Login_state.dart';
import 'package:shopapp/auth/login/login_cubit/login_cubit.dart';
import 'package:shopapp/auth/register/shop_register_screen.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/helper/constans/const.dart';
import 'package:shopapp/helper/shared_preference/shared_pref.dart';
import 'package:shopapp/views/shop_layout.dart';

class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.userLoginModel!.status!) {
              CacheHelper.saveData(
                key: 'token',
                value: state.userLoginModel!.data!.token,
              ).then(
                (value) {
                  token = state.userLoginModel!.data!.token;
                  navigateAndFinish(
                    // ignore: use_build_context_synchronously
                    context: context,
                    widget: const ShopLayout(),
                  );
                },
              );
            } else {
              defaultToast(
                msg: state.userLoginModel!.message,
                state: ToastStates.error,
              );
            }
          }
        },
        builder: (context, state) {
          LoginCubit loginCubit = LoginCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: loginCubit.loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        defuaLtFormField(
                          controller: loginCubit.emailController,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            // Additional email validation (optional)
                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          labelText: 'Email',
                          type: TextInputType.emailAddress,
                          prefix: Icons.email,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defuaLtFormField(
                          controller: loginCubit.passController,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onSubmit: (p0) {
                            if (loginCubit.loginFormKey.currentState!
                                .validate()) {
                              loginCubit.userLogin(
                                email: loginCubit.emailController.text,
                                password: loginCubit.passController.text,
                              );
                            }
                          },
                          labelText: 'Password',
                          type: TextInputType.visiblePassword,
                          suffix: loginCubit.suffix,
                          prefix: Icons.lock,
                          obscureText: loginCubit.isPassword,
                          suffixPressed: () {
                            loginCubit.changePasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          builder: (context) => defaultButton(
                            onPressed: () {
                              if (loginCubit.loginFormKey.currentState!
                                  .validate()) {
                                loginCubit.userLogin(
                                  email: loginCubit.emailController.text,
                                  password: loginCubit.passController.text,
                                );
                              }
                            },
                            text: 'login',
                            isUppercase: true,
                            color: Colors.lightGreen,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            defaultTextButton(
                              text: 'Register now',
                              onPressed: () {
                                navigateTo(
                                  context: context,
                                  widget: const ShopRegisterScreen(),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

