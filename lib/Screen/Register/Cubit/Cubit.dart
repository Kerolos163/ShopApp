import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Cubit/state.dart';

import '../../../Helper/DioHelper.dart';
import '../../../Helper/end_points.dart';
import '../../../model/LoginModel.dart';
import 'State.dart';

class ShopRegisterCubit extends Cubit<RegisterState> {
  ShopRegisterCubit() : super(ShopRegisterInitState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  bool Isvisible = false;
  void ChangeVisiability() {
    Isvisible = !Isvisible;
    emit(ShopChangeVisiabilityState());
  }

  late ShopLoginModel model;
  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(ShopRegisterLoadingState());
    DioHelper.PostData(
            url: REGISTER,
            data: {
              'email': email,
              'password': password,
              'name': name,
              'phone': phone,
            },
            lang: 'ar')
        .then((value) {
      model = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(model));
    }).catchError((Error) {
      print(Error.toString());
      emit(ShopRegisterErrorState(Error.toString()));
    });
  }
}
