part of 'quote_cubit.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object> get props => [];
}

class QuoteInitial extends QuoteState {}

class QuoteIsLoading extends QuoteState {}

class QuoteLoaded extends QuoteState {
  final Quote quote;

  const QuoteLoaded({required this.quote});

  @override
  List<Object> get props => [quote];
}

class QuoteError extends QuoteState {
  final String msg;

  const QuoteError({required this.msg});

  @override
  List<Object> get props => [msg];
}
