import 'package:flutter/material.dart';
import 'components.dart';
import 'package:time_formatter/time_formatter.dart';
import 'server_data.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen({this.infoData});
  final infoData;
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  void initState() {
    super.initState();
    updateUI(widget.infoData);
  }

  void updateUI(dynamic decodedData) {
    setState(() {
      if (decodedData == null) {
        players = 0;
        isOnline = false;
        serverStatus = 'OFFLINE';
        time = '0';
        return;
      }
      players = decodedData['players']['now'];
      isOnline = decodedData['online'];
      time = decodedData['last_updated'];
      int timeInt = int.parse(time);
      lastUpdated = formatTime(timeInt * 1000);
      print(lastUpdated);
      if (isOnline == true) {
        serverStatus = 'ONLINE';
      } else {
        serverStatus = 'OFFLINE';
      }
    });
  }

  String time;
  int players;
  bool isOnline;
  String serverStatus;
  String lastUpdated;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Hero(
                tag: 'logo',
                child: Image.asset('images/logo.png'),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    child: Center(
                      child: Text(
                        '$serverStatus',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Minecraft',
                          fontSize: 34.0,
                          color: isOnline == true ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                flex: 4,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    child: Center(
                      child: Text(
                        'Players: ${players.toString()}',
                        style: TextStyle(
                          fontFamily: 'Minecraft',
                          fontSize: 32.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ColorizeAnimatedTextKit(
                        textAlign: TextAlign.end,
                        alignment: AlignmentDirectional.centerEnd,
                        textStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w900,
                        ),
                        text: ['Last updated:'],
                        colors: [
                          Colors.purple,
                          Colors.blue,
                          Colors.yellow,
                          Colors.red,
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child: Text(
                        '$lastUpdated',
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        setState(() async {
                          var decodedData = await ServerData().getData();
                          updateUI(decodedData);
                        });
                      },
                      icon: Icon(Icons.refresh),
                    ),
                    SizedBox(width: 20.0,),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.message),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Logos(
                        image: 'images/logo_mc.png',
                        margin: EdgeInsets.only(top: 100.0, right: 50.0),
                      ),
                    ),
                    Expanded(
                      child: Logos(
                        image: 'images/logo_rapiddev.png',
                        margin: EdgeInsets.only(top: 100.0, left: 50.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}