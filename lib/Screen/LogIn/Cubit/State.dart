import '../../../model/LoginModel.dart';

abstract class LogInState {}

class ShopLogInInitState extends LogInState {}
class ShopChangeVisiabilityState extends LogInState {}

class ShopLogInLoadingState extends LogInState {}

class ShopLogInSuccessState extends LogInState {
  ShopLoginModel model;
  ShopLogInSuccessState(this.model);
}

class ShopLogInErrorState extends LogInState {
  String Error;
  ShopLogInErrorState(this.Error);
}
