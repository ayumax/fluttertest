import 'package:flutter/cupertino.dart';

class TweetItem extends ChangeNotifier {
  String userName;
  String accountName;
  String tweet;

  TweetItem.fromTweetInfo(this.userName, this.accountName, this.tweet);

  void editTweet(String newTweet) {
    this.tweet = newTweet;
    notifyListeners();
  }
}

class TweetClient extends ChangeNotifier {
  final _tweets = <TweetItem>[];
  List<TweetItem> get tweets => _tweets;

  void doTweet(String userName, String accountName, String tweetString) {
    _tweets.add(TweetItem.fromTweetInfo(userName, accountName, tweetString));

    notifyListeners();
  }
}
