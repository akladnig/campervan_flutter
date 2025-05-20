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
  var _isDisposed = false;

  @override
  Future<WebSocketChannel?> build() async {
    if (channel != null) return channel;

    await connect();
    listen();
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

  final streamController = StreamController<Map<String, dynamic>>();
  Stream<Map<String, dynamic>> get stream => streamController.stream;

  void listen() {
    Map<String, dynamic> jsonData = {};
    if (_isDisposed) return;

    channel?.stream.listen(
      (data) {
        jsonData = jsonDecode(data as String) as Map<String, dynamic>;
        streamController.add(jsonData);
        debugPrint('${jsonData.runtimeType}: $jsonData');
      },
      onError: (e) {
        reconnect();
      },
    );
  }

  void send(String message) {
    channel?.sink.add(message);
  }

  Future<WebSocketChannel?> reconnect() async {
    if (_isDisposed) return null;

    await Future.delayed(const Duration(seconds: 3));

    return connect();
  }

  void close() {
    _isDisposed = true;
    channel?.sink.close;
  }
}

@riverpod
Future<DeviceMap> deviceCharacteristics(Ref ref) async {
  final jsonDataStream = ref.watch(arduinoWebSocketProvider.notifier).stream;
  final first = await jsonDataStream.first;
  debugPrint('first: ${first.toString()}');

  final devicesCharacteristics = DeviceMap.fromJson(first);
  debugPrint('chars: ${devicesCharacteristics.toString()}');

  return devicesCharacteristics;
}
