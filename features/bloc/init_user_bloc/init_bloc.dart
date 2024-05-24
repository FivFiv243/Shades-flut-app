import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huui/abstractions/abstract_getter_repository.dart';

part 'init_event.dart';
part 'init_state.dart';

class InitBloc extends Bloc<InitEvent, InitState> {
  InitBloc(this.shadesRepository) : super(InitInitial()) {
    on<ListLoadingEvent>((event, emit) async{
      try {
        if(state is! InitialLoaded){
      emit(InitialazingLoading());}
/*add logic that works with firebase*/ 
  emit(InitialLoaded());
}catch (e) {
  debugPrint(e.toString());
      emit(InitialFailed(exception: e));
        }
    });
  }


  final AbstractShadesRepository shadesRepository;
}