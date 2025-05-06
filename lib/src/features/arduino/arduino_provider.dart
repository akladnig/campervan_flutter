import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

part 'arduino_provider.g.dart';

@riverpod
Stream<List<String>> arduinoStream(Ref ref) async* {
  /// Create the WebSocket channel
  final arduinoWsUrl = '192.168.20.46';
  final channel = WebSocketChannel.connect(Uri.parse(arduinoWsUrl));

  ref.onDispose(channel.sink.close);

  await channel.ready;

  channel.stream.listen((message) {
    channel.sink.add('received!');
    channel.sink.close(status.goingAway);
  });
}
