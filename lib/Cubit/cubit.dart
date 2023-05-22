import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/state.dart';
import 'package:shop_app/imp_func.dart';

import '../Helper/DioHelper.dart';
import '../Helper/Share_Pref.dart';
import '../Helper/end_points.dart';
import '../Screen/Products/ProductScreen.dart';
import '../Screen/categories/CategoriesScreen.dart';
import '../Screen/favorites/FavoriteScreen.dart';
import '../Screen/settings/settingScreen.dart';
import '../model/Favoritemodel.dart';
import '../model/GetFavoriteModel.dart';
import '../model/Homemodel.dart';
import '../model/LoginModel.dart';
import '../model/categories_model.dart';

class AppCubit extends Cubit<ShopState> {
  AppCubit() : super(ShopInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  int CurrentIndex = 0;

  List<Widget> BottomScreens = [
    const ProductScreen(),
    const CategoriesScreen(),
    const FavoriteScreen(),
    SettingScreen()
  ];

  void ChangeBottom(int index) {
    CurrentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  Map<int, bool>? favorites = {};
  HomeModel? homemodel;
  void getHomemodel() {
    emit(ShopLoadingHomeDataState());
    DioHelper.GetData(url: HOME, Authorization: Token).then((value) {
      homemodel = HomeModel.fromJson(value.data);
      // print(value.data);
      homemodel!.data.products.forEach((element) {
        favorites!.addAll({element.id: element.in_favorites});
      });
      // print(favorites);
      emit(ShopSuccessHomeDataState());
    }).catchError((Error) {
      emit(ShopErrorHomeDataState(Error.toString()));
    });
  }

  Categoriesmodel? categoriesmodel;
  void getcategoriesmodel() {
    emit(ShopLoadingcategoriesDataState());
    DioHelper.GetData(url: GET_GATEGORIES, Authorization: Token).then((value) {
      categoriesmodel = Categoriesmodel.fromJson(value.data);
      // print(value.data);
      emit(ShopSuccesscategoriesDataState());
    }).catchError((Error) {
      emit(ShopErrorcategoriesDataState(Error.toString()));
    });
  }

  Favoritemodel? favoritemodel;
  void changeFavorites(int productindex) {
    favorites![productindex] = !favorites![productindex]!;
    emit(ShopchangefavoriteState());
    DioHelper.PostData(
            url: Favorites,
            data: {"product_id": productindex},
            Authorization: Token)
        .then((value) {
      // print(value.data);
      favoritemodel = Favoritemodel.fromJson(value.data);
      // print(favoritemodel!.message);
      if (!favoritemodel!.status) {
        favorites![productindex] = !favorites![productindex]!;
      } else {
        getFavoritesmodel();
      }
      emit(ShopSuccesschangefavoriteState(favoritemodel!));
    }).catchError((Error) {
      favorites![productindex] = !favorites![productindex]!;
      emit(ShopErrorchangefavoriteState(favoritemodel!));
    });
  }

  FavoriteGetModel? favoritegetmodel;
  void getFavoritesmodel() {
    emit(ShopLoadingGetfavoriteState());
    DioHelper.GetData(url: Favorites, Authorization: Token).then((value) {
      favoritegetmodel = FavoriteGetModel.fromJson(value.data);
      // print(value.data);
      emit(ShopSuccessGetfavoriteState());
    }).catchError((Error) {
      emit(ShopErrorGetfavoriteState(Error.toString()));
    });
  }

  ShopLoginModel? UserModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.GetData(url: PROFILE, Authorization: Token).then((value) {
      UserModel = ShopLoginModel.fromJson(value.data);
      print("*" * 50);
      print(UserModel!.data!.name);
      emit(ShopSuccessUserDataState());
    }).catchError((Error) {
      emit(ShopErrorUserDataState(Error.toString()));
    });
  }

  void UpDateUserData({required name, required email, required phone}) {
    emit(ShopLoadingUpDateState());
    DioHelper.PutData(url: UPDATEPROFILE, Authorization: Token, data: {
      'name': name,
      'phone': phone,
      'email': email,
    }).then((value) {
      UserModel = ShopLoginModel.fromJson(value.data);
      print("*" * 50);
      print(UserModel!.data!.name);
      emit(ShopSuccessUpDateState());
    }).catchError((Error) {
      emit(ShopErrorUpDateState(Error.toString()));
    });
  }

  void logout() {
    Sharepref.deletedata(key: 'Token').then((value) {
      emit(ShopSuccessLogOutState());
    });
  }
}
