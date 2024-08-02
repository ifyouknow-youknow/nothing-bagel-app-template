import 'dart:io';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';

class Sound {
  final AudioRecorder _recorder = AudioRecorder();
  String? audioPath;

  Future<void> startRecording() async {
    print("THINGS");
    if (await _recorder.hasPermission()) {
      final directory = await getApplicationDocumentsDirectory();
      audioPath = '${directory.path}/recording.mp3';
      print("RECORDING");
      await _recorder.start(const RecordConfig(), path: audioPath!);
    }
  }

  Future<void> stopRecording() async {
    audioPath = await _recorder.stop();
    print('AUDIO PATH: $audioPath');
    print("RECODING STOPPED");
  }

  Future<void> playRecording() async {
    if (audioPath != null) {
      final player = AudioPlayer();
      await player.setFilePath(audioPath!);
      player.play();
    }
  }
}
