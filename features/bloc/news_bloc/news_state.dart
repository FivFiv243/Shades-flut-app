
part of 'news_bloc.dart';

abstract class NewsState extends Equatable{}


class NewsInitial extends NewsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NewsListLoading extends NewsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NewsListReloading extends NewsState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ListLoadingFailed extends NewsState{
  ListLoadingFailed({
    this.exception,
  });
  final Object? exception;
  
  @override
  // TODO: implement props
  List<Object?> get props => [exception];
}

class NewsListLoaded extends NewsState{
  NewsListLoaded({required this.newsList});
  final List<News> newsList;
  
  @override
  // TODO: implement props
  List<Object?> get props => [newsList];
}
