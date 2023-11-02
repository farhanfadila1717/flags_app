import 'package:flags_app/core/models/about/about.dart';
import 'package:flags_app/core/models/flag/flag.dart';
import 'package:flags_app/core/models/quiz/question.dart';
import 'package:flags_app/core/redux/states/authentication_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const AppState._();

  const factory AppState({
    @Default(AuthenticationState()) AuthenticationState authState,
    @Default([]) List<Question> questions,
    @Default([]) List<Flag> flags,
    About? about,
  }) = _AppState;
}
