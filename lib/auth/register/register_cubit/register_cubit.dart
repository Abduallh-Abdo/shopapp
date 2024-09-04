import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/auth/register/register_cubit/register_state.dart';
import 'package:shopapp/helper/constans/end_points.dart';
import 'package:shopapp/helper/dio/dio_helper.dart';
import 'package:shopapp/models/user_login_model.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  UserLoginModel? userRegisterModel;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(RegisterLoadingState());

    DioHelper.postData(
      url: EndPoints.register,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
      lang: 'en',
       

    ).then((value) {
      // print(value.data);
      userRegisterModel = UserLoginModel.fromJson(
        value.data,
      );

      emit(RegisterSuccessState(userRegisterModel));
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }
}
