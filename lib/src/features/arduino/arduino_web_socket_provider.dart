import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:campervan/src/features/arduino/arduino_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'arduino_web_socket_provider.g.dart';

@Riverpod(keepAlive: true)
class ArduinoWebSocket extends _$ArduinoWebSocket {
  WebSocketChannel? channel;

  @override
  Future<WebSocketChannel?> build() async {
    if (channel != null) return channel;

    await connect();
    debugPrint('Arduino Web socket - connnected');
    return channel;
  }

  Future<WebSocketChannel> connect() async {
    final myWsIp = '192.168.20.7';
    final port = 80;
    channel = WebSocketChannel.connect(Uri.parse('ws://$myWsIp:$port/ws'));

    try {
      await channel?.ready;
    } on SocketException catch (e) {
      debugPrint('socket Exception: $e');
    } on WebSocketChannelException catch (e) {
      debugPrint('socket Exception: $e');
    }
    debugPrint('Websocket: $channel connected');
    return channel!;
  }
}

class ArduinoRepository {
  final WebSocketChannel channel;
  var _isDisposed = false;

  final streamController = StreamController<Map<String, dynamic>>();

  ArduinoRepository(this.channel) {
    listen(channel);
  }

  Stream<Map<String, dynamic>> get stream => streamController.stream;

  void listen(WebSocketChannel channel) {
    Map<String, dynamic> jsonData = {};
    if (_isDisposed) return;

    channel.stream.listen(
      (data) {
        jsonData = jsonDecode(data as String) as Map<String, dynamic>;
        streamController.add(jsonData);
        debugPrint('${jsonData.runtimeType}: $jsonData');
      },
      onError: (e) {
        // reconnect();
      },
    );
  }

  void send(WebSocketChannel channel, String message) {
    channel.sink.add(message);
  }

  // Future<WebSocketChannel?> reconnect() async {
  //   if (_isDisposed) return null;

  //   await Future.delayed(const Duration(seconds: 3));

  //   return connect();
  // }

  void close(WebSocketChannel channel) {
    _isDisposed = true;
    channel.sink.close;
  }
}

@riverpod
Stream<Map<String, dynamic>> jsonStream(Ref ref) async* {
  final channel = await ref.watch(arduinoWebSocketProvider.future);
  final arduinoRepo = ArduinoRepository(channel!);
  final jsonDataStream = arduinoRepo.stream;

  await for (final json in jsonDataStream) {
    debugPrint('first: ${json.toString()}');
    yield json;
  }
}

@riverpod
Future<DeviceMap> deviceCharacteristics(Ref ref) async {
  final json = await ref.watch(jsonStreamProvider.future);
  debugPrint('json: ${json.toString()}');

  final devicesCharacteristics = DeviceMap.fromJson(json);
  debugPrint('chars: ${devicesCharacteristics.toString()}');

  return devicesCharacteristics;
}
