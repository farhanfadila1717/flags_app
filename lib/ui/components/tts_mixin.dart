import 'dart:convert';

import 'package:flags_app/core/redux/action_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState {
  playing,
  stopped,
}

mixin TtsMixin<T extends StatefulActionMapper> on State<T> {
  late final ValueNotifier<String> speakingWord;
  TtsState ttsState = TtsState.stopped;
  int speakIndex = 0;
  int paraghraphIndex = 0;
  String rawText = '';

  void initTts(String text) {
    speakingWord = ValueNotifier('');
    rawText = text;
    listenTts();
  }

  void listenTts() {
    flutterTts.setStartHandler(() {
      ttsState = TtsState.playing;
      setState(() {});
    });

    flutterTts.setCancelHandler(() {
      ttsState = TtsState.stopped;
      setState(() {});
    });

    flutterTts.setProgressHandler(
      (_, start, end, word) {
        speakIndex = end;
        speakingWord.value = word;
      },
    );
  }

  void playAudio() async {
    LineSplitter ls = const LineSplitter();

    final lines = ls.convert(rawText);

    if (paraghraphIndex == lines.length) {
      setState(() {
        ttsState = TtsState.stopped;
        paraghraphIndex = 0;
        speakIndex = 0;
        speakingWord.value = '';
      });
      return;
    }

    final text = lines[paraghraphIndex].trim();
    final speakText = text.substring(speakIndex, text.length);

    if (speakText.trim().isEmpty) {
      _nextParagraph(1);
    }

    final result = await flutterTts.speak(speakText);

    _nextParagraph(result);
  }

  void _nextParagraph(int result) {
    if (result == 1) {
      paraghraphIndex++;
      speakIndex = 0;
      playAudio();
    }
  }

  FlutterTts get flutterTts => widget.getIt.get<FlutterTts>();
}
