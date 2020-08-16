import 'package:flutter/material.dart';
import 'package:fluttertest/bloc/tweet_client.dart';
import 'package:provider/provider.dart';

class TweetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ツイート'),
      ),
      body: _TweetControl(),
    );
  }
}

class _TweetControl extends StatelessWidget {
  final _tweetTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                onPressed: () {
                  Provider.of<TweetClient>(context, listen: false)
                      .doTweet(_tweetTextController.text);

                  Navigator.of(context).pop();
                },
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text(
                  'ツイートする',
                  style: Theme.of(context).primaryTextTheme.button,
                ),
              )
            ],
          ),
          TextField(
            controller: _tweetTextController,
            maxLines: 10,
            decoration: const InputDecoration(hintText: 'いまどうしてる？'),
          )
        ],
      ),
    );
  }
}
//
