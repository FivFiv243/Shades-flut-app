part of 'init_bloc.dart';

abstract class InitState extends Equatable{}
 
class InitInitial extends InitState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialazingLoading extends InitState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitalReloading extends InitState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialFailed extends InitState{
  InitialFailed({
    this.exception,
  });
  final Object? exception;
  
  @override
  // TODO: implement props
  List<Object?> get props => [exception];
}

class InitialLoaded extends InitState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
