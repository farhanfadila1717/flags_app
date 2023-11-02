import 'package:flags_app/core/redux/action_mapper.dart';
import 'package:flags_app/core/redux/actions/app_action.dart';
import 'package:flags_app/ui/components/default_store_connector.dart';
import 'package:flags_app/ui/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AboutDialog extends StatefulActionMapper {
  const AboutDialog({super.key});

  @override
  State<AboutDialog> createState() => _AboutDialogState();
}

class _AboutDialogState extends State<AboutDialog> {
  late final AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    final about = widget.store.state.about;
    if (about == null) {
      widget.dispatch(
        const GetAboutAction(),
      );
    } else {
      _initAudio(about.audio);
    }
  }

  void _initAudio(String url) async {
    try {
      await _player.setUrl(url);
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: DefaultStoreConnector(onDidChange: (previousState, state) async {
          if (previousState?.about?.audio != state.about?.audio) {
            if (state.about?.audio == null) return;
            await _player.setUrl(state.about!.audio);
          }
        }, builder: (context, state) {
          final about = state.about;

          if (about == null) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tentang',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                about.creator,
              ),
              const SizedBox(height: 16),
              Text(
                'Pembimbing Materi: ${about.dospem1}',
              ),
              const SizedBox(height: 16),
              Text(
                'Pembimbing Teknik: ${about.dospem2}',
              ),
              const SizedBox(height: 16),
              if (about.audio.isNotEmpty)
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: StreamBuilder<PlayerState>(
                    stream: _player.playerStateStream,
                    builder: (context, snapshot) {
                      final playerState = snapshot.data;
                      final processingState = playerState?.processingState;
                      final playing = playerState?.playing;
                      if (processingState == ProcessingState.loading ||
                          processingState == ProcessingState.buffering) {
                        return const Center(
                          child: SizedBox.square(
                            dimension: 24,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (playing != true) {
                        return PrimaryButton(
                          onTap: _player.play,
                          child: const Icon(Icons.play_arrow),
                        );
                      } else if (processingState != ProcessingState.completed) {
                        return PrimaryButton(
                          onTap: _player.pause,
                          child: const Icon(Icons.pause),
                        );
                      } else {
                        return PrimaryButton(
                          onTap: () => _player.seek(Duration.zero),
                          child: const Icon(Icons.replay),
                        );
                      }
                    },
                  ),
                ),
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: PrimaryButton(
                  text: 'Oke',
                  color: Colors.green,
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
