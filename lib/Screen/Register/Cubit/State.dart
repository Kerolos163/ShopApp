import '../../../model/LoginModel.dart';

abstract class RegisterState {}

class ShopRegisterInitState extends RegisterState {}
class ShopChangeVisiabilityState extends RegisterState {}

class ShopRegisterLoadingState extends RegisterState {}

class ShopRegisterSuccessState extends RegisterState {
  ShopLoginModel model;
  ShopRegisterSuccessState(this.model);
}

class ShopRegisterErrorState extends RegisterState {
  String Error;
  ShopRegisterErrorState(this.Error);
}
