import 'package:equatable/equatable.dart';

class Shares extends Equatable{
  const Shares({
    required this.Name,
    required this.PrevPrice,
    required this.BoardId,
    required this.Secid,
    required this.MinStep,
  });

  final String Name;
  final String PrevPrice;
  final dynamic BoardId;
  final dynamic Secid;
  final String MinStep;
  
  @override
  // TODO: implement props
  List<Object?> get props => [Name,PrevPrice,BoardId,Secid,MinStep];

}