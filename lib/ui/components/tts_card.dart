import 'package:flags_app/ui/components/tts_mixin.dart';
import 'package:flutter/material.dart';

class TtsCard extends StatelessWidget {
  const TtsCard({
    super.key,
    required this.speakingWord,
    required this.ttsState,
    required this.onPlay,
    required this.onPause,
  });

  final ValueNotifier<String> speakingWord;
  final TtsState ttsState;
  final VoidCallback onPlay;
  final VoidCallback onPause;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        children: [
          Builder(
            builder: (_) {
              if (ttsState == TtsState.playing) {
                return FloatingActionButton(
                  heroTag: 'pause',
                  onPressed: onPause,
                  child: const Icon(Icons.pause),
                );
              }
              return FloatingActionButton(
                heroTag: 'play',
                onPressed: onPlay,
                child: const Icon(Icons.library_music_outlined),
              );
            },
          ),
          const SizedBox(width: 16),
          ValueListenableBuilder(
            valueListenable: speakingWord,
            builder: (_, word, __) {
              if (word.isEmpty || ttsState == TtsState.stopped) {
                return const SizedBox.shrink();
              }

              return DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.volume_up,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        word,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
