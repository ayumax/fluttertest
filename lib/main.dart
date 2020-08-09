import 'package:flutter/material.dart';

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
        home: Scaffold(
          appBar: AppBar(title: Text("test")),
          body: NewView(),
        ));
  }
}

class NewView extends StatelessWidget {
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
            "ayumax ",
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
