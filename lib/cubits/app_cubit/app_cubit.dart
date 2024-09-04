import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubits/app_cubit/app_state.dart';
import 'package:shopapp/helper/constans/const.dart';
import 'package:shopapp/helper/constans/end_points.dart';
import 'package:shopapp/helper/dio/dio_helper.dart';
import 'package:shopapp/helper/shared_preference/shared_pref.dart';
import 'package:shopapp/models/categories_model.dart';
import 'package:shopapp/models/favorites_change_model.dart';
import 'package:shopapp/models/get_favorites_model.dart';
import 'package:shopapp/models/home_model.dart';
import 'package:shopapp/models/user_login_model.dart';
import 'package:shopapp/views/catagories/catagories_screen.dart';
import 'package:shopapp/views/favorites/favorites_screen.dart';
import 'package:shopapp/views/products/products_screen.dart';
import 'package:shopapp/views/settings/setting_screen.dart';

class AppCubit extends Cubit<AppStates> {
  bool isDark = false;

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomNavBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home_filled,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.apps,
      ),
      label: 'Catagories',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite,
      ),
      label: 'Favorites',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ];

  List<Widget> screens = [
    const ProductsScreen(),
    const CatagoriesScreen(),
    const FavoritesScreen(),
    const SettingScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  void changeAppMode({dynamic fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
      CacheHelper.saveData(
        key: 'isDark',
        value: isDark,
      ).then((value) {
        emit(AppChanegeModeState());
      });
    }
    emit(AppChanegeModeState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(AppLoadingHomeDataState());
    DioHelper.getData(
      url: EndPoints.home,
      token: token,
      lang: 'en',
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      for (var element in homeModel!.data!.products) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      }
      // print(favorites.toString());
      emit(AppSuccessHomeDataState());
    }).catchError((error) {
      emit(AppErrorHomeDataState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;
  void getCatagories() {
    DioHelper.getData(
      url: EndPoints.getCategories,
      lang: 'en',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(AppSuccessHomeDataState());
    }).catchError((error) {
      emit(AppErrorHomeDataState(error.toString()));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites({required int productId}) {
    favorites[productId] = !favorites[productId]!;
    emit(AppChangeFavoritesState());
    DioHelper.postData(
            url: EndPoints.favorites,
            data: {
              'product_id': productId,
            },
            token: token,
            lang: 'en')
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (changeFavoritesModel!.status == false) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavourites();
      }
      emit(AppSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(AppErrorChangeFavoritesState(error.toString()));
    });
  }

  GetFavoritesModel? getFavoritesModel;
  void getFavourites() {
    emit(AppLoadingGetFavoritesState());
    DioHelper.getData(
      url: EndPoints.favorites,
      token: token,
      lang: 'en',
    ).then((value) {
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);

      emit(AppSuccessGetFavoritesState());
    }).catchError((error) {
      emit(AppErrorGetFavoritesState(error.toString()));
    });
  }

  UserLoginModel? userProfileModel;
  void getProfile() {
    emit(AppLoadingProfileState());

    DioHelper.getData(
      url: EndPoints.profile,
      token: token,
      lang: 'en',
    ).then((value) {
      userProfileModel = UserLoginModel.fromJson(value.data);
      emit(AppSuccessProfileState());
    }).catchError((error) {
      emit(AppErrorProfileState(error.toString()));
    });
  }

  UserLoginModel? userUpdateProfileModel;
  void updateProfile({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(AppLoadingUpdateProfileState());
    DioHelper.putData(
        url: EndPoints.updateProfile,
        token: token,
        lang: 'en',
        data: {
          'name': name,
          'email': email,
          'phone': phone,
        }).then((value) {
      userUpdateProfileModel = UserLoginModel.fromJson(value.data);
      getProfile();
      emit(AppSuccessUpdateProfileState(userUpdateProfileModel!));
    }).catchError((error) {
      emit(AppErrorUpdateProfileState(error.toString()));
    });
  }
}
