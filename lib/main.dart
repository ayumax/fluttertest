import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertest/bloc/tweetClient.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],
        ),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => TweetClient(),
              )
            ],
            child: Scaffold(
                appBar: AppBar(title: Text("test")),
                body: HomeView(),
                floatingActionButton: _TweetFloatingActionButton())));
  }
}

class _TweetFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Provider.of<TweetClient>(context, listen: false)
          .doTweet("userName", "accountName", "テスト投稿"),
      tooltip: 'Tweet',
      child: Icon(Icons.send),
    );
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => TweetItemTile(index),
        separatorBuilder: (context, index) => Divider(color: Colors.black),
        itemCount: Provider.of<TweetClient>(context).tweets.length);
  }
}

class TweetItemTile extends StatelessWidget {
  final int index;

  const TweetItemTile(this.index);

  @override
  Widget build(BuildContext context) {
    return Consumer<TweetClient>(
      builder: (context, value, child) {
        final tweetData = value.tweets[index];
        return TweetItemControl(tweetData);
      },
    );
  }
}

class TweetItemControl extends StatelessWidget {
  final TweetItem tweetItem;

  const TweetItemControl(this.tweetItem);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          width: 30,
          height: 30,
          margin: EdgeInsets.all(10),
          child: Image.asset("images/Icon.jpg")),
      Flexible(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(
            "ayumax",
            style: Theme.of(context).primaryTextTheme.overline,
          ),
          Text(
            "@ayuma_x",
            style: Theme.of(context).primaryTextTheme.overline,
          ),
        ]),
        Text(
            "これからFlutterの学習をしていきます。\nまずはTwitterの見た目を再現してみたいと思います。いずれは動的に表示したいですが、まずは静的な見た目で。",
            textAlign: TextAlign.left,
            style: Theme.of(context).primaryTextTheme.bodyText2)
      ])),
    ]);
  }
}
