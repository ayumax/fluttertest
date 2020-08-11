import 'dart:convert';
import 'dart:io';
import 'package:rxdart/rxdart.dart';

class TCPIPClient {
  Socket _socket;
  final _subject = PublishSubject<String>();
  bool _isEnd = false;

  TCPIPClient();

  Future connect(String ipAddress, int port) async {
    while (_isEnd == false) {
      try {
        _socket = await Socket.connect(ipAddress, port);
        break;
      } catch (e) {}
    }

    if (_isEnd == true || _socket == null) return;

    _socket.listen((event) {});
  }

  Future<int> sendString(String stringFroSend) async {
    if (_socket == null) return 0;

    final bodyBuffer = utf8.encode(stringFroSend);
    final sendBufferSize = bodyBuffer.length;
    final sendBufferSizeBuffer = [
      (sendBufferSize >> 24) & 0xff,
      (sendBufferSize >> 16) & 0xff,
      (sendBufferSize >> 8) & 0xff,
      sendBufferSize & 0xff
    ];

    _socket.add(sendBufferSizeBuffer);
    _socket.add(bodyBuffer);

    await _socket.flush();

    return sendBufferSize + 4;
  }

  Future close() async {
    if (_socket == null) return 0;

    await _socket.flush();
    await _socket.close();

    _socket = null;
  }
}
