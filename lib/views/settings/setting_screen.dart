import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/auth/login/shop_login_screen.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/cubits/app_cubit/app_cubit.dart';
import 'package:shopapp/cubits/app_cubit/app_state.dart';
import 'package:shopapp/helper/shared_preference/shared_pref.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    TextEditingController? emailController = TextEditingController();
    TextEditingController? nameController = TextEditingController();
    TextEditingController? phoneController = TextEditingController();

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        if (appCubit.userProfileModel != null &&
            appCubit.userProfileModel!.data != null) {
          nameController.text = appCubit.userProfileModel!.data!.name ?? '';
          emailController.text = appCubit.userProfileModel!.data!.email ?? '';
          phoneController.text = appCubit.userProfileModel!.data!.phone ?? '';
        }
        return Scaffold(
          body: ConditionalBuilder(
            condition: appCubit.userProfileModel != null &&
                appCubit.userProfileModel!.data != null,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Image.network(
                          fit: BoxFit.cover,
                          appCubit.userProfileModel!.data!.image.toString(),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defuaLtFormField(
                        controller: nameController,
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
                        controller: emailController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
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
                        controller: phoneController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone';
                          }
                          return null;
                        },
                        labelText: 'Phone',
                        type: TextInputType.phone,
                        prefix: Icons.phone,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ConditionalBuilder(
                        condition: state is! AppLoadingUpdateProfileState,
                        fallback: (context) => const LinearProgressIndicator(),
                        builder: (context) => defaultButton(
                          color: Colors.lightGreen,
                          text: 'Update',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              appCubit.updateProfile(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                        color: Colors.red,
                        text: 'Logout',
                        onPressed: () {
                          CacheHelper.signOut(key: 'token');
                          navigateAndFinish(
                              context: context,
                              widget: const ShopLoginScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
