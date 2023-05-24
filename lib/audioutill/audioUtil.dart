import 'package:audioplayers/audioplayers.dart';

class AudioUtil {
  static final player = AudioPlayer();

  static void audioplay() async {
    await player.play(AssetSource('sound/mouse_click.mp3'));
  }
}
