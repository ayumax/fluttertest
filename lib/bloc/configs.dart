import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum EServerOrClient { server, client }

class Configs extends ChangeNotifier {
  String _userName = 'user';
  String get userName => _userName;
  set userName(String newValue) {
    _userName = newValue;
    saveValues();
  }

  EServerOrClient _serverOrClient = EServerOrClient.client;
  EServerOrClient get serverOrClient => _serverOrClient;
  set serverOrClient(EServerOrClient newValue) {
    _serverOrClient = newValue;
    saveValues();
  }

  String get serverOrClientText =>
      serverOrClient == EServerOrClient.client ? 'Client' : 'Server';
  String _ipAddress = '10.0.2.2';
  String get ipAddress => _ipAddress;
  set ipAddress(String newValue) {
    _ipAddress = newValue;
    saveValues();
  }

  int _port = 9013;
  int get port => _port;
  set port(int newValue) {
    _port = newValue;
    saveValues();
  }

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

  void saveValues() {
    serializeConfigs();
    notifyListeners();
  }
}
