import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/helper/constans/const.dart';
import 'package:shopapp/helper/constans/end_points.dart';
import 'package:shopapp/helper/dio/dio_helper.dart';
import 'package:shopapp/models/search_model.dart';
import 'package:shopapp/views/search/search_cubit/search_state.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  var formKey = GlobalKey<FormState>();
  TextEditingController? textController = TextEditingController();

  SearchModel? searchModel;
  void search({required String text}) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: EndPoints.search,
      data: {
        'text': text,
      },
      lang: 'en', 
      token: token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel.toString());
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState(error.toString()));
    });
  }
}
