import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flags_app/core/models/flag/flag.dart';
import 'package:flags_app/core/models/quiz/answer.dart';
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

const questionPost = <Question>[
  Question(
    no: 1,
    question: 'Negara manakah yang memiliki bendera ini?',
    image: '',
    answers: [
      Answer(
        text: 'Amerika',
      ),
      Answer(
        text: 'Jepang',
      ),
      Answer(
        text: 'Kanada',
        correct: true,
      ),
      Answer(
        text: 'China',
      ),
    ],
    audio: '',
    level: 1,
  ),
  Question(
    no: 2,
    question: 'Negara manakah yang memiliki bendera ini?',
    image: '',
    answers: [
      Answer(
        text: 'Italia',
      ),
      Answer(
        text: 'Inggris',
      ),
      Answer(
        text: 'Perancis',
      ),
      Answer(
        text: 'Amerika',
        correct: true,
      ),
    ],
    audio: '',
    level: 1,
  ),
  Question(
    no: 3,
    question: 'Negara manakah yang memiliki bendera ini?',
    image: '',
    answers: [
      Answer(
        text: 'Inggris',
        correct: true,
      ),
      Answer(
        text: 'Jerman',
      ),
      Answer(
        text: 'Vietnam',
      ),
      Answer(
        text: 'Indonesia',
      ),
    ],
    audio: '',
    level: 1,
  ),
  Question(
    no: 3,
    question: 'Negara manakah yang memiliki bendera ini?',
    image: '',
    answers: [
      Answer(
        text: 'Inggris',
        correct: true,
      ),
      Answer(
        text: 'Jerman',
      ),
      Answer(
        text: 'Vietnam',
      ),
      Answer(
        text: 'Indonesia',
      ),
    ],
    audio: '',
    level: 1,
  ),
  Question(
    no: 4,
    question: 'Negara manakah yang memiliki bendera ini?',
    image: '',
    answers: [
      Answer(
        text: 'Rusia',
      ),
      Answer(
        text: 'Brazil',
        correct: true,
      ),
      Answer(
        text: 'China',
      ),
      Answer(
        text: 'Islandia',
      ),
    ],
    audio: '',
    level: 1,
  ),
  Question(
    no: 5,
    question: 'Negara manakah yang memiliki bendera ini?',
    image: '',
    answers: [
      Answer(
        text: 'Amerika',
      ),
      Answer(
        text: 'Inggris',
      ),
      Answer(
        text: 'Jepang',
        correct: true,
      ),
      Answer(
        text: 'Korea Selatan',
      ),
    ],
    audio: '',
    level: 1,
  ),
  Question(
    no: 6,
    question: 'Negara manakah yang memiliki bendera ini?',
    image: '',
    answers: [
      Answer(
        text: 'China',
        correct: true,
      ),
      Answer(
        text: 'Jepang',
      ),
      Answer(
        text: 'Kanada',
      ),
      Answer(
        text: 'Indonesia',
      ),
    ],
    audio: '',
    level: 1,
  ),
  Question(
    no: 7,
    question: 'Negara manakah yang memiliki bendera ini?',
    image: '',
    answers: [
      Answer(
        text: 'Chili',
      ),
      Answer(
        text: 'Portugal',
      ),
      Answer(
        text: 'Spanyol',
        correct: true,
      ),
      Answer(
        text: 'Belanda',
      ),
    ],
    audio: '',
    level: 1,
  ),
  Question(
    no: 8,
    question: 'Negara manakah yang memiliki bendera ini?',
    image: '',
    answers: [
      Answer(
        text: 'Inggris',
        correct: true,
      ),
      Answer(
        text: 'Jerman',
      ),
      Answer(
        text: 'Vietnam',
      ),
      Answer(
        text: 'Indonesia',
      ),
    ],
    audio: '',
    level: 1,
  ),
  Question(
    no: 9,
    question: 'Negara manakah yang memiliki bendera ini?',
    image: '',
    answers: [
      Answer(
        text: 'Australia',
      ),
      Answer(
        text: 'Italia',
        correct: true,
      ),
      Answer(
        text: 'Selandia Baru',
      ),
      Answer(
        text: 'Jerman',
      ),
    ],
    audio: '',
    level: 1,
  ),
  Question(
    no: 10,
    question: 'Negara manakah yang memiliki bendera ini?',
    image: '',
    answers: [
      Answer(
        text: 'Polandia',
      ),
      Answer(
        text: 'Brazil',
      ),
      Answer(
        text: 'Jerman',
        correct: true,
      ),
      Answer(
        text: 'Yunani',
      ),
    ],
    audio: '',
    level: 1,
  ),
  Question(
    no: 5,
    question: 'Negara manakah yang memiliki bendera ini?',
    image: '',
    answers: [
      Answer(
        text: 'Amerika',
      ),
      Answer(
        text: 'Inggris',
      ),
      Answer(
        text: 'Jepang',
        correct: true,
      ),
      Answer(
        text: 'Korea Selatan',
      ),
    ],
    audio: '',
    level: 1,
  ),
];
