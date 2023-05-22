import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screen/search/cubit/state.dart';

import '../../../Helper/DioHelper.dart';
import '../../../Helper/end_points.dart';
import '../../../imp_func.dart';
import '../../../model/SearchModel.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SeacriniteState());

  static SearchCubit get(context) => BlocProvider.of(context);

  Searchmodel? model;
  void Search({required String Text}) {
    emit(SeacrLoadingState());
    DioHelper.PostData(
        url: SEARCHPRODUCT,
        Authorization: Token,
        data: {'text': Text}).then((value) {
      // print(value.data);
      model = Searchmodel.fromJson(value.data);
      print(model!.data!.data);
      emit(SeacrSuccessState());
    }).catchError((Error) {
      print(Error.toString());
      emit(SeacrErrorState());
    });
  }
}
