import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertest/bloc/configs.dart';
import 'package:fluttertest/bloc/tweetClient.dart';
import 'package:fluttertest/tweetView.dart';
import 'package:provider/provider.dart';

void main() {
  final _configs = Configs();
  _configs.deserializeConfigs();

  runApp(MyApp(_configs));
}

// ライフサイクル対応をココみて実装すること
// https://qiita.com/kurun_pan/items/0c6de1313844a8cc1603

class MyApp extends StatelessWidget {
  final Configs _configs;

  MyApp(this._configs);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: _configs),
          ChangeNotifierProvider(
            create: (_) => TweetClient(_configs),
          )
        ],
        child: MaterialApp(
            theme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.lightBlue[800],
              accentColor: Colors.cyan[600],
            ),
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: Scaffold(
                appBar: AppBar(title: Text('Flutterさんぷる')),
                body: HomeView(),
                floatingActionButton: _TweetFloatingActionButton())));
  }
}

class _TweetFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TweetView(),
          )),
      tooltip: 'Tweet',
      child: Icon(Icons.send),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final teetClient = Provider.of<TweetClient>(context);
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: teetClient.tweets[index],
              child: TweetItemTile(),
            ),
        separatorBuilder: (context, index) =>
            Divider(color: Theme.of(context).dividerColor),
        itemCount: teetClient.tweets.length);
  }
}

class TweetItemTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TweetItem>(
        builder: (context, value, child) => TweetItemControl(value));
  }
}

class TweetItemControl extends StatelessWidget {
  final TweetItem tweetItem;

  const TweetItemControl(this.tweetItem);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.all(2),
              child: Image.asset(tweetItem.icon)),
          Flexible(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(children: [
                  Text(
                    tweetItem.userName,
                    style: Theme.of(context).primaryTextTheme.overline,
                  ),
                  Text(
                    tweetItem.accountName,
                    style: Theme.of(context).textTheme.overline,
                  ),
                ]),
                Text(tweetItem.tweet,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).primaryTextTheme.bodyText2)
              ])),
        ]));
  }
}
