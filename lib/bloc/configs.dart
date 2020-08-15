import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum EServerOrClient { server, client }

class Configs extends ChangeNotifier {
  EServerOrClient serverOrClient = EServerOrClient.client;
  String ipAddress = '10.0.2.2';
  int port = 9013;

  final _updateConfig = StreamController<Configs>.broadcast();
  Stream<Configs> get updateConfig => _updateConfig.stream;

  void deserializeConfigs() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey('serverOrClient')) {
      serverOrClient = pref.getString('serverOrClient') == 'server'
          ? EServerOrClient.server
          : EServerOrClient.client;
    }

    if (pref.containsKey('ipAddress')) {
      ipAddress = pref.getString('ipAddress');
    }

    if (pref.containsKey('port')) {
      port = pref.getInt('port');
    }
  }

  void serializeConfigs() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('serverOrClient', serverOrClient.toString());
    await pref.setString('ipAddress', ipAddress);
    await pref.setInt('port', port);
  }

  void updateSocket() {
    _updateConfig.sink.add(this);
  }
}
