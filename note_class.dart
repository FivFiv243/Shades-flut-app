import 'package:equatable/equatable.dart';

class Note extends Equatable{
  const Note ({
    required this.Name,
    required this.Body,
  });
  final String Name;
  final String Body;

  List <Object?> get props => [Name, Body];
}