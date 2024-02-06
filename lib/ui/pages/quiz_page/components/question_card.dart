import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flags_app/core/models/quiz/answer.dart';
import 'package:flags_app/core/models/quiz/question.dart';
import 'package:flags_app/core/redux/action_mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_tts/flutter_tts.dart';

class QuestionCard extends StatefulActionMapper {
  const QuestionCard({
    super.key,
    required this.question,
    required this.answers,
    required this.onAnswer,
  });

  final Question question;
  final Map<Question, Answer> answers;
  final ValueChanged<Answer> onAnswer;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    _playAudio();
  }

  void _playAudio() {
    String voiceText =
        '${widget.question.question}. Pilihan jawabannya adalah ';

    for (int i = 0; i < widget.question.answers.length; i++) {
      voiceText +=
          '${String.fromCharCode(65 + i)} ${widget.question.answers[i].text}\n';
    }
    flutterTts.speak(voiceText);
  }

  FlutterTts get flutterTts => widget.getIt.get<FlutterTts>();

  void _onSelectAnswer(Answer answer) {
    widget.onAnswer(answer);
    flutterTts.speak('Anda memilih ${answer.text}');
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.question;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (question.image.isNotEmpty)
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(question.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: AnimatedTextKit(
              key: ValueKey(question),
              totalRepeatCount: 1,
              animatedTexts: [
                TypewriterAnimatedText(
                  question.question,
                  textAlign: TextAlign.center,
                  textStyle: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        ...List.generate(
          question.answers.length,
          (index) {
            final item = question.answers[index];
            bool selected = false;

            if (widget.answers.containsKey(question)) {
              selected = widget.answers[question] == item;
            }

            final String text =
                '${String.fromCharCode(65 + index)}. ${item.text}';

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: () => _onSelectAnswer(item),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color:
                        selected ? Colors.blue.withOpacity(.8) : Colors.white,
                    border: selected ? null : Border.all(),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        text,
                        style: TextStyle(
                          color: selected ? Colors.white : Colors.black,
                          fontWeight:
                              selected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
                .animate(
                  key: ValueKey(item),
                  delay: Duration(milliseconds: 200 * index),
                )
                .fadeIn();
          },
        ),
      ],
    );
  }
}
