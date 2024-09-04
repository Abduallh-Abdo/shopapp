import 'package:shopapp/models/favorites_change_model.dart';
import 'package:shopapp/models/user_login_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppLoadingHomeDataState extends AppStates {}

class AppSuccessHomeDataState extends AppStates {}

class AppErrorHomeDataState extends AppStates {
  final String error;
  AppErrorHomeDataState(this.error);
}

class AppLoadingGetFavoritesState extends AppStates {}

class AppSuccessGetFavoritesState extends AppStates {}

class AppErrorGetFavoritesState extends AppStates {
  final String error;
  AppErrorGetFavoritesState(this.error);
}

class AppLoadingProfileState extends AppStates {}

class AppSuccessProfileState extends AppStates {}

class AppErrorProfileState extends AppStates {
  final String error;
  AppErrorProfileState(this.error);
}


class AppLoadingUpdateProfileState extends AppStates {}

class AppSuccessUpdateProfileState extends AppStates {
  final UserLoginModel model;
  AppSuccessUpdateProfileState(this.model);
}

class AppErrorUpdateProfileState extends AppStates {
  final String error;
  AppErrorUpdateProfileState(this.error);
}

class AppSuccessCategoriesState extends AppStates {}

class AppErrorCategoriesState extends AppStates {
  final String error;
  AppErrorCategoriesState(this.error);
}

class AppChangeFavoritesState extends AppStates {}
class AppSuccessChangeFavoritesState extends AppStates {
  final ChangeFavoritesModel model;
  AppSuccessChangeFavoritesState(this.model);
}

class AppErrorChangeFavoritesState extends AppStates {
  final String error;
  AppErrorChangeFavoritesState(this.error);
}

class AppChanegeModeState extends AppStates {}

class AppChanegeOnBoardingState extends AppStates {}

class ShopChangeBottomNavState extends AppStates {}
