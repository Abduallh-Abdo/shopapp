import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/auth/login/shop_login_screen.dart';
import 'package:shopapp/cubits/app_cubit/app_cubit.dart';
import 'package:shopapp/cubits/app_cubit/app_state.dart';
import 'package:shopapp/helper/constans/const.dart';
import 'package:shopapp/helper/constans/themes/theme_app.dart';
import 'package:shopapp/helper/shared_preference/shared_pref.dart';
import 'package:shopapp/views/onboarding.dart';
import 'package:shopapp/views/shop_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  Widget widget;
  onBoarding = CacheHelper.getData(key: 'onBoarding')??false;
  isDark = CacheHelper.getData(key: 'isDark')??true;
  token=CacheHelper.getData(key: 'token')??'';

// Check if onboarding is completed
  if (onBoarding != null && onBoarding) {
    if (token != null && token!.isNotEmpty) {
      widget = const ShopLayout(); // Navigate to the main shop layout
    } else {
      widget = const ShopLoginScreen(); // Navigate to the login screen
    }
  } else {
    widget = const OnboardingScreen(); // Navigate to the onboarding screen
  }
  print(token);
  runApp(ShopApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class ShopApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  const ShopApp({
    required this.isDark,
    required this.startWidget,
  }) : super(key: null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getHomeData()
        ..getCatagories()
        ..getFavourites()
        ..getProfile()
        ..changeAppMode(fromShared: isDark),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
