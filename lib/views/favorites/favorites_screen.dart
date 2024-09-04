import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/cubits/app_cubit/app_cubit.dart';
import 'package:shopapp/cubits/app_cubit/app_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is! AppLoadingGetFavoritesState) {}

        if (state is AppSuccessChangeFavoritesState) {
          if (state.model.status == false) {
            defaultToast(
              msg: state.model.message,
              state: ToastStates.error,
            );
          }
          if (state.model.status == true) {
            defaultToast(
              msg: state.model.message,
              state: ToastStates.success,
            );
          }
        }
      },
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          body:ConditionalBuilder(
  condition: appCubit.homeModel != null && 
             appCubit.categoriesModel != null && 
             appCubit.getFavoritesModel != null, // Ensures getFavoritesModel is not null
  fallback: (context) => const Center(
    child: CircularProgressIndicator(),
  ),
  builder: (context) {
    // Check if there are any favorite items
    if (appCubit.getFavoritesModel!.data!.data.isEmpty) {
      return Center(
        child: Text('No Favorites Items'),
      );
    } else {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: appCubit.getFavoritesModel!.data!.data.length,
        itemBuilder: (context, index) {
          final favoriteItem = appCubit.getFavoritesModel!.data!.data[index];
          
          // Check if the product is null
          if (favoriteItem.product == null) {
            return Center(
              child: Text('No Favorites Items'),
            );
          } else {
            return dafaultCatoItem(
              context: context,
              model: favoriteItem.product!,
            );
          }
        },
      );
    }
  },
),

        );
      },
    );
  }
}
