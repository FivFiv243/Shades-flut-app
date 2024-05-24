part of 'my_homepage_block.dart';

abstract class HomepageState extends Equatable{}
 
class HomepageInitial extends HomepageState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ShadesListLoading extends HomepageState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ShadesListReloading extends HomepageState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ListLoadingFailed extends HomepageState{
  ListLoadingFailed({
    this.exception,
  });
  final Object? exception;
  
  @override
  // TODO: implement props
  List<Object?> get props => [exception];
}

class ShadesListLoaded extends HomepageState{
  ShadesListLoaded({required this.shadesList});
  final List<Shares> shadesList;
  
  @override
  // TODO: implement props
  List<Object?> get props => [shadesList];
}
