part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  final Locale locale;
  const AppState(this.locale);

  @override
  List<Object> get props => [locale];
}

class ChangeLocaleState extends AppState {
  const ChangeLocaleState(Locale selectedLocale) : super(selectedLocale);
}
