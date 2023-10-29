import 'package:flags_app/core/models/flag/flag.dart';
import 'package:flags_app/core/redux/action_mapper.dart';
import 'package:flags_app/ui/components/tts_card.dart';
import 'package:flags_app/ui/components/tts_mixin.dart';
import 'package:flutter/material.dart';

class DetailFlagPage extends StatefulActionMapper {
  const DetailFlagPage({
    super.key,
    required this.flag,
  });

  final Flag flag;

  @override
  State<DetailFlagPage> createState() => _DetailFlagPageState();
}

class _DetailFlagPageState extends State<DetailFlagPage> with TtsMixin {
  @override
  void initState() {
    super.initState();
    initTts('${widget.flag.name}\n${widget.flag.descriptions}');
  }

  @override
  void dispose() {
    speakingWord.dispose();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.flag.name,
        ),
      ),
      floatingActionButton: TtsCard(
        speakingWord: speakingWord,
        ttsState: ttsState,
        onPlay: playAudio,
        onPause: flutterTts.stop,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFCBBDFF),
                  Color(0xFF589AF0),
                ],
              ),
            ),
            child: Center(
              child: Text(
                widget.flag.flag,
                style: const TextStyle(
                  fontSize: 100,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.flag.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.flag.descriptions,
          ),
        ],
      ),
    );
  }
}
