import 'package:equatable/equatable.dart';

abstract class AppSuccess extends Equatable {
  const AppSuccess({required this.message});
  final String message;
}

class SuccessMessage extends AppSuccess {
  const SuccessMessage({required super.message});

  @override
  List<Object?> get props => [message];
}
