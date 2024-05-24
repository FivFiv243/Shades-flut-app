import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huui/abstractions/news_abstraction.dart';
import 'package:huui/features/news_info/News_model.dart';

part 'news_event.dart';
part 'news_state.dart';



class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc(this.shadesRepository) : super(NewsInitial()) {
    on<ListLoadingEvent>((event, emit) async{
      try {
  if(state is! NewsListLoaded){
      emit(NewsListLoading());
  }
  final NewsList = await shadesRepository.getnewsfor();
  emit(NewsListLoaded(newsList: NewsList));
}catch (e) {
  debugPrint(e.toString());
      emit(ListLoadingFailed(exception: e));
        }
    });
  }


  final NewsAbstractRepo shadesRepository;
}