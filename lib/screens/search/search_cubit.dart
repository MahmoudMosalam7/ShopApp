import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshopapp/network/remote/dio_helper.dart';
import 'package:newshopapp/screens/search/search_states.dart';
import 'package:newshopapp/shared/component.dart';

import '../../models/search_model.dart';
import '../../network/end_points.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text)
  {
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
      'text' : text
    }).then((value){
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
    });
  }

}