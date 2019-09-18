import 'dart:async';
import 'package:flutter/material.dart';
import '../data/server_data.dart';
import 'info_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WaitingScreen extends StatefulWidget {
  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  Future getServerData() async {
    var playersData =
        await ServerData().getPlayersData().timeout(Duration(seconds: 7));
    print(playersData);
    try {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return InfoScreen(
            playersData: playersData,
          );
        }),
      );
    } on TimeoutException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getServerData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: SpinKitRipple(color: Colors.white, size: 100.0),
        ),
        Expanded(
          child: Hero(
            tag: 'logo',
            child: Image.asset('images/logo.png'),
          ),
        ),
      ],
    ));
  }
}
