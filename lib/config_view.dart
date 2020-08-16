import 'package:flutter/material.dart';
import 'package:fluttertest/bloc/configs.dart';
import 'package:fluttertest/bloc/tweet_client.dart';
import 'package:provider/provider.dart';

class ConfigView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('設定'),
      ),
      body: _ConfigListView(),
    );
  }
}

class _ConfigListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(8), children: [
      ListTile(
        title: Text('User'),
      ),
      _ListRowUserName(),
      ListTile(
        title: Text('Socket'),
      ),
      _ListRowServerMode(),
      _ListRowIpAddress(),
      _ListRowIpPort(),
      _ListRowUpdateSocket()
    ]);
  }
}
//

class _ListRowUserName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
        child: ListTile(
            leading: const Icon(Icons.account_circle),
            title: Text('User名'),
            subtitle: context.select((Configs config) => Text(config.userName)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _UserNameEditView(),
                  ));
            }));
  }
}

class _UserNameEditView extends StatelessWidget {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final configs = Provider.of<Configs>(context, listen: false);
    _textEditingController.text = configs.userName;

    return Scaffold(
        appBar: AppBar(
          title: Text('User名'),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: TextField(
            maxLines: 1,
            decoration: const InputDecoration(hintText: 'User名を入力'),
            controller: _textEditingController,
            keyboardType: TextInputType.name,
            onChanged: (value) => configs.userName = value,
          ),
        ));
  }
}

class _ListRowServerMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
        child: ListTile(
            leading: const Icon(Icons.router),
            title: Text('Socketモード'),
            subtitle: context
                .select((Configs config) => Text(config.serverOrClientText)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _SocketModeEditView(),
                  ));
            }));
  }
}

class _SocketModeEditView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final configs = Provider.of<Configs>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Socketモード設定'),
        ),
        body: Container(
          child: Column(
            children: [
              RadioListTile<EServerOrClient>(
                  title: Text('Server'),
                  value: EServerOrClient.server,
                  groupValue: configs.serverOrClient,
                  onChanged: (x) => configs.serverOrClient = x),
              RadioListTile<EServerOrClient>(
                  title: Text('Client'),
                  value: EServerOrClient.client,
                  groupValue: configs.serverOrClient,
                  onChanged: (x) => configs.serverOrClient = x),
            ],
          ),
        ));
  }
}

class _ListRowIpAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
        child: ListTile(
            leading: const Icon(Icons.place),
            title: Text('IPアドレス'),
            subtitle:
                context.select((Configs config) => Text(config.ipAddress)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _IPAddressEditView(),
                  ));
            }));
  }
}

class _IPAddressEditView extends StatelessWidget {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final configs = Provider.of<Configs>(context, listen: false);
    _textEditingController.text = configs.ipAddress;

    return Scaffold(
        appBar: AppBar(
          title: Text('IPAddress'),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: TextField(
            maxLines: 1,
            decoration: const InputDecoration(hintText: 'ServerのIPAddressを入力'),
            controller: _textEditingController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => configs.ipAddress = value,
          ),
        ));
  }
}

class _ListRowIpPort extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
        child: ListTile(
            leading: const Icon(Icons.assistant_photo),
            title: Text('Port'),
            subtitle:
                context.select((Configs config) => Text('${config.port}')),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _PortEditView(),
                  ));
            }));
  }
}

class _PortEditView extends StatelessWidget {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final configs = Provider.of<Configs>(context, listen: false);
    _textEditingController.text = '${configs.port}';

    return Scaffold(
        appBar: AppBar(
          title: Text('Port'),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: TextField(
            maxLines: 1,
            decoration: const InputDecoration(hintText: '接続するPort番号を入力'),
            controller: _textEditingController,
            keyboardType: TextInputType.number,
            onChanged: (value) => configs.port = int.tryParse(value),
          ),
        ));
  }
}

class _ListRowUpdateSocket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tweet = Provider.of<TweetClient>(context);

    return Container(
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Theme.of(context).dividerColor),
          ),
        ),
        child: ListTile(
          leading: Icon(Icons.refresh,
              color: tweet.socketState == '接続済み'
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).disabledColor),
          title: Text('接続'),
          subtitle:
              context.select((TweetClient tweet) => Text(tweet.socketState)),
          onTap: () {
            tweet.updateSocket();
          },
        ));
  }
}
