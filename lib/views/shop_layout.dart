import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubits/app_cubit/app_cubit.dart';
import 'package:shopapp/cubits/app_cubit/app_state.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/views/search/search_screen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Shop App',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  appCubit.changeAppMode();
                },
                icon: const Icon(Icons.brightness_4_outlined),
              ),
              IconButton(
                onPressed: () {
                  navigateAndFinish(
                      context: context, widget: const SearchScreen());
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          body: appCubit.screens[appCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: appCubit.currentIndex,
            onTap: (index) => appCubit.changeBottomNavBar(index),
            items: appCubit.bottomNavBarItem,
          ),
        );
      },
    );
  }
}
