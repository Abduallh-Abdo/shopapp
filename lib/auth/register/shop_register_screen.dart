import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/auth/login/shop_login_screen.dart';
import 'package:shopapp/auth/register/register_cubit/register_cubit.dart';
import 'package:shopapp/auth/register/register_cubit/register_state.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/cubits/app_cubit/app_cubit.dart';
import 'package:shopapp/helper/constans/const.dart';
import 'package:shopapp/helper/shared_preference/shared_pref.dart';
import 'package:shopapp/views/shop_layout.dart';

class ShopRegisterScreen extends StatelessWidget {
  const ShopRegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.userRegisterModel!.status!) {
              CacheHelper.saveData(
                key: 'token',
                value: state.userRegisterModel!.data!.token,
              ).then(
                (value) {
                  token = state.userRegisterModel!.data!.token;
                  navigateAndFinish(
                    context: context,
                    widget: const ShopLayout(),
                  );
                  AppCubit.get(context).getProfile();
                },
              );
            } else {
              defaultToast(
                msg: state.userRegisterModel!.message,
                state: ToastStates.error,
              );
            }
          }
        },
        builder: (context, state) {
          RegisterCubit registerCubit = RegisterCubit.get(context);
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: registerCubit.registerFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        defuaLtFormField(
                          controller: registerCubit.nameController,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }

                            return null;
                          },
                          labelText: 'Name',
                          type: TextInputType.name,
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defuaLtFormField(
                          controller: registerCubit.emailController,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            // Additional email validation (optional)
                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email address';
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
                          controller: registerCubit.phoneController,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                          labelText: 'Phone',
                          type: TextInputType.phone,
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defuaLtFormField(
                          controller: registerCubit.passController,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onSubmit: (p0) {
                            if (registerCubit.registerFormKey.currentState!
                                .validate()) {
                              registerCubit.userRegister(
                                name: registerCubit.nameController.text,
                                email: registerCubit.emailController.text,
                                phone: registerCubit.phoneController.text,
                                password: registerCubit.passController.text,
                              );
                            }
                          },
                          labelText: 'Password',
                          type: TextInputType.visiblePassword,
                          suffix: registerCubit.suffix,
                          prefix: Icons.lock,
                          obscureText: registerCubit.isPassword,
                          suffixPressed: () {
                            registerCubit.changePasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          builder: (context) => defaultButton(
                            onPressed: () {
                              if (registerCubit.registerFormKey.currentState!
                                  .validate()) {
                                registerCubit.userRegister(
                                  name: registerCubit.nameController.text,
                                  email: registerCubit.emailController.text,
                                  phone: registerCubit.phoneController.text,
                                  password: registerCubit.passController.text,
                                );
                              }
                            },
                            text: 'Register',
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
                              'Already have an account?',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            defaultTextButton(
                              text: 'Login now',
                              onPressed: () {
                                navigateTo(
                                  context: context,
                                  widget: const ShopLoginScreen(),
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
