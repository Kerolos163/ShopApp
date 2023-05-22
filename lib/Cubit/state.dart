import '../model/Favoritemodel.dart';

abstract class ShopState {}

class ShopInitState extends ShopState {}

class ShopChangeBottomNavState extends ShopState {}

class ShopLoadingHomeDataState extends ShopState {}

class ShopSuccessHomeDataState extends ShopState {}

class ShopErrorHomeDataState extends ShopState {
  String Error;
  ShopErrorHomeDataState(this.Error);
}

class ShopLoadingcategoriesDataState extends ShopState {}

class ShopSuccesscategoriesDataState extends ShopState {}

class ShopErrorcategoriesDataState extends ShopState {
  String Error;
  ShopErrorcategoriesDataState(this.Error);
}

class ShopchangefavoriteState extends ShopState {}

class ShopSuccesschangefavoriteState extends ShopState {
  Favoritemodel model;
  ShopSuccesschangefavoriteState(this.model);
}

class ShopErrorchangefavoriteState extends ShopState {
  Favoritemodel model;
  ShopErrorchangefavoriteState(this.model);
}

class ShopLoadingGetfavoriteState extends ShopState {
}
class ShopSuccessGetfavoriteState extends ShopState {
}

class ShopErrorGetfavoriteState extends ShopState {
    String Error;
  ShopErrorGetfavoriteState(this.Error);
}
class ShopLoadingUserDataState extends ShopState {
}
class ShopSuccessUserDataState extends ShopState {
}

class ShopErrorUserDataState extends ShopState {
    String Error;
  ShopErrorUserDataState(this.Error);
}
class ShopLoadingUpDateState extends ShopState {
}
class ShopSuccessUpDateState extends ShopState {
}

class ShopErrorUpDateState extends ShopState {
    String Error;
  ShopErrorUpDateState(this.Error);
}

class ShopSuccessLogOutState extends ShopState {}
