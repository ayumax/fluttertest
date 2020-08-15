import 'package:flutter/material.dart';
import 'package:fluttertest/bloc/configs.dart';

import 'package:objectdeliverer_dart/objectdeliverer_dart.dart';

class TweetItem extends ChangeNotifier implements IJsonSerializable {
  String userName;
  String accountName;
  String tweet;
  String icon;

  TweetItem.fromTweetInfo(this.userName, this.accountName, this.tweet)
      : icon = 'images/Icon.jpg';

  TweetItem.fromJson(Map<String, dynamic> json)
      : userName = json['userName'] as String,
        accountName = json['accountName'] as String,
        tweet = json['tweet'] as String,
        icon = 'images/Icon.jpg';

  @override
  Map<String, dynamic> toJson() => {
        'userName': userName,
        'accountName': accountName,
        'tweet': tweet,
      };
}

class TweetClient extends ChangeNotifier {
  final Configs _configs;

  TweetClient(this._configs) {
    IJsonSerializable.addMakeInstanceFunction(
        TweetItem, (json) => TweetItem.fromJson(json));

    _configs.updateConfig.listen((x) => updateSocket());

    updateSocket();
  }

  final _tweets = <TweetItem>[];
  List<TweetItem> get tweets => _tweets;

  ObjectDelivererManager<TweetItem> objectDeliverer;

  void doTweet(String userName, String accountName, String tweetString) async {
    if (objectDeliverer == null) {
      return;
    }

    final tweetItem =
        TweetItem.fromTweetInfo(userName, accountName, tweetString);
    _tweets.add(tweetItem);

    await objectDeliverer.sendMessageAsync(tweetItem);

    notifyListeners();
  }

  Future updateSocket() async {
    if (objectDeliverer != null) {
      await objectDeliverer.close();
    }

    objectDeliverer = ObjectDelivererManager<TweetItem>()
      ..receiveData.listen((x) {
        x.message.icon = 'images/server.png';
        tweets.add(x.message);
        notifyListeners();
      });

    ObjectDelivererProtocol protocol;

    switch (_configs.serverOrClient) {
      case EServerOrClient.server:
        protocol = ProtocolTcpIpServer.fromParam(_configs.port);
        break;
      case EServerOrClient.client:
        protocol = ProtocolTcpIpClient.fromParam(
            _configs.ipAddress, _configs.port,
            autoConnectAfterDisconnect: true);
        break;
    }

    await objectDeliverer.startAsync(protocol, PacketRuleSizeBody.fromParam(4),
        ObjectJsonDeliveryBox<TweetItem>());
  }
}
