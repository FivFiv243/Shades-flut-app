import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huui/abstractions/abstract_getter_repository.dart';
import 'package:huui/features/shares_class.dart';

part 'my_homepage_events.dart';
part 'my_homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc(this.shadesRepository) : super(HomepageInitial()) {
    on<ListLoadingEvent>((event, emit) async{
      try {
  if(state is! ShadesListLoaded){
      emit(ShadesListLoading());
  }
  final ShadisList = await shadesRepository.getinfofor();
  emit(ShadesListLoaded(shadesList: ShadisList));
  debugPrint('its loades');
  debugPrint(ShadisList[0].Secid.toString());
}catch (e) {
  debugPrint(e.toString());
      emit(ListLoadingFailed(exception: e));
        }
    });
  }


  final AbstractShadesRepository shadesRepository;
}