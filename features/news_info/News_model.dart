import 'package:equatable/equatable.dart';
class News extends Equatable{
  const News({
    required this.Imagen,
    required this.Name,
    required this.Texter 
  });

  final dynamic Name;
  final dynamic Texter;
  final dynamic Imagen;

  @override
  // TODO: implement props
  List<Object?> get props => [Name,Texter,Imagen];
}