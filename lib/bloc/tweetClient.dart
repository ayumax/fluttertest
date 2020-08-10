import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:async';

class TweetItem extends ChangeNotifier {
  String userName;
  String accountName;
  String tweet;

  TweetItem.fromTweetInfo(this.userName, this.accountName, this.tweet);

  TweetItem.fromJson(Map<String, dynamic> json)
      : userName = json['userName'],
        accountName = json['accountName'],
        tweet = json['tweet'];

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'accountName': accountName,
        'tweet': tweet,
      };
}

class TweetClient extends ChangeNotifier {
  final _tweets = <TweetItem>[];
  List<TweetItem> get tweets => _tweets;

  void doTweet(String userName, String accountName, String tweetString) async {
    final tweetItem =
        TweetItem.fromTweetInfo(userName, accountName, tweetString);
    _tweets.add(tweetItem);

    String tweetItemJson = jsonEncode(tweetItem);

    final socket = await Socket.connect("10.0.2.2", 9013);

    final tweetItemJsonBuffer = utf8.encode(tweetItemJson);
    final sendBufferSize = tweetItemJsonBuffer.length;
    final sendBufferSizeBuffer = [
      (sendBufferSize >> 24) & 0xff,
      (sendBufferSize >> 16) & 0xff,
      (sendBufferSize >> 8) & 0xff,
      sendBufferSize & 0xff
    ];

    socket.add(sendBufferSizeBuffer);
    socket.add(tweetItemJsonBuffer);

    await socket.flush();

    await socket.close();

    notifyListeners();
  }
}
