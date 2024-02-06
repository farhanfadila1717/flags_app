import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flags_app/core/models/about/about.dart';
import 'package:flags_app/core/models/flag/flag.dart';
import 'package:flags_app/core/models/quiz/question.dart';
import 'package:flags_app/core/redux/actions/app_action.dart';
import 'package:flags_app/core/redux/states/app_state.dart';
import 'package:flags_app/core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:redux/redux.dart';

class AppMiddleware extends MiddlewareClass<AppState> {
  AppMiddleware();

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    switch (action.runtimeType) {
      case InitTtsAction:
        _onInitTtsAction(store, action);
        break;
      case GetQuestionsAction:
        _onGetQuestionsAction(store, action);
        break;
      case GetFlagsAction:
        _onGetFlagsAction(store, action);
        break;
      case GetAboutAction:
        _onGetAboutAction(store, action);
        break;
    }

    next(action);
  }

  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  Future<void> _onInitTtsAction(
    Store<AppState> store,
    InitTtsAction action,
  ) async {
    try {
      final flutterTts = getIt.get<FlutterTts>();

      await flutterTts.awaitSpeakCompletion(true);
      await flutterTts.setLanguage('id-ID');
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  Future<void> _onGetQuestionsAction(
    Store<AppState> store,
    GetQuestionsAction action,
  ) async {
    try {
      final quiz = firestore.collection('quiz');

      final quizs = await quiz.get();

      List<Question> questions = [];
      for (var i in quizs.docs) {
        questions.add(Question.fromJson(i.data()));
      }

      questions.sort((a, b) => a.no.compareTo(b.no));

      store.dispatch(
        SetQuestionsAction(questions),
      );
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  Future<void> _onGetFlagsAction(
    Store<AppState> store,
    GetFlagsAction action,
  ) async {
    try {
      final flagsCollection = firestore.collection('flags');

      final response = await flagsCollection.get();

      List<Flag> flags = [];
      for (var i in response.docs) {
        flags.add(Flag.fromJson(i.data()));
      }

      flags.sort((a, b) => a.name.compareTo(b.name));

      store.dispatch(
        SetFlagsAction(flags),
      );
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  Future<void> _onGetAboutAction(
    Store<AppState> store,
    GetAboutAction action,
  ) async {
    try {
      final collection = firestore.collection('about');

      final response = await collection.get();

      store.dispatch(
        SetAboutAction(
          About.fromJson(
            response.docs.first.data(),
          ),
        ),
      );
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }
}

String generateRandomString(int length) {
  final random = Random();
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  String temp = '';

  for (int i = 0; i < length; i++) {
    temp += chars[random.nextInt(chars.length - 1)];
  }

  return temp;
}
