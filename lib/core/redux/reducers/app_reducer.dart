import 'package:flags_app/core/redux/actions/app_action.dart';
import 'package:flags_app/core/redux/states/app_state.dart';
import 'package:redux/redux.dart';

final appReducer = combineReducers<AppState>(
  [
    TypedReducer<AppState, SetQuestionsAction>(_onSetQuestionsAction),
    TypedReducer<AppState, SetFlagsAction>(_onSetFlagsAction),
    TypedReducer<AppState, SetAboutAction>(_onSetAboutAction),
  ],
);

AppState _onSetQuestionsAction(
  AppState state,
  SetQuestionsAction action,
) {
  return state.copyWith(
    questions: action.questions,
  );
}

AppState _onSetFlagsAction(
  AppState state,
  SetFlagsAction action,
) {
  return state.copyWith(
    flags: action.flags,
  );
}

AppState _onSetAboutAction(
  AppState state,
  SetAboutAction action,
) {
  return state.copyWith(
    about: action.about,
  );
}
