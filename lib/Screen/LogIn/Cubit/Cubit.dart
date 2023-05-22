import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/state.dart';

import '../../../Helper/DioHelper.dart';
import '../../../Helper/end_points.dart';
import '../../../model/LoginModel.dart';
import 'State.dart';

class ShopLogInCubit extends Cubit<LogInState> {
  ShopLogInCubit() : super(ShopLogInInitState());

  static ShopLogInCubit get(context) => BlocProvider.of(context);

  bool Isvisible = false;
  void ChangeVisiability() {
    Isvisible = !Isvisible;
    emit(ShopChangeVisiabilityState());
  }

  late ShopLoginModel model;
  void userLogIn({required String email, required String password}) {
    emit(ShopLogInLoadingState());
    DioHelper.PostData(
            url: LOGIN,
            data: {'email': email, 'password': password},
            lang: 'ar')
        .then((value) {
      model = ShopLoginModel.fromJson(value.data);
      emit(ShopLogInSuccessState(model));
    }).catchError((Error) {
      print(Error.toString());
      emit(ShopLogInErrorState(Error.toString()));
    });
  }

}
