import 'package:flutter/material.dart';
import '../components/components.dart';
import '../data/server_data.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:share/share.dart';
import 'package:intl/intl.dart';

class InfoScreen extends StatefulWidget {
  InfoScreen({this.playersData});
  final playersData;
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  void initState() {
    super.initState();
    updateUI(widget.playersData);
  }

  void updateUI(dynamic decodedData) {
    setState(() {
      if (decodedData == null) {
        players = 0;
        isOnline = false;
        serverStatus = 'OFFLINE';
        lastUpdated = '0';
        return;
      }
      players = decodedData['players']['online'];
      isOnline = decodedData['online'];
      lastUpdated = DateFormat("yyyy.MM.dd  H:mm").format(DateTime.now());
      print(lastUpdated);
      if (isOnline == true) {
        serverStatus = 'ONLINE';
      } else {
        serverStatus = 'OFFLINE';
      }
      if (players != 0) {
        playersList = decodedData['players']['list'];
      }
    });
  }

  var playersList;
  int players;
  bool isOnline;
  String serverStatus;
  String lastUpdated;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
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
                    child: FlatButton(
                      onPressed: players == 0
                          ? null
                          : () {
                              setState(() {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                          bottom: 20.0,
                                          top: 90.0),
                                      child: Container(
                                        child: ListView.builder(
                                          itemCount: players == null
                                              ? players = 0
                                              : players, //widget.playersData['players']['list'] == null ? 0 : widget.playersData['players']['list'].length,
                                          itemBuilder: (context, index) {
                                            return Center(
                                              child: Column(
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      playersList[index],
                                                      style: TextStyle(
                                                        color: playersList[
                                                                    index] !=
                                                                'Pomian'
                                                            ? Colors.white
                                                            : Colors.red,
                                                        fontSize: 30.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Minecraft',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF222224),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                        ),
                                      ),
                                    );
                                  },
                                );
                                //setLoading = false;
                              });
                            },
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
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: ColorizeAnimatedTextKit(
                          textAlign: TextAlign.end,
                          alignment: AlignmentDirectional.centerEnd,
                          textStyle: TextStyle(
                            fontFamily: 'Minecraft',
                            fontSize: 14.0,
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
                        height: 5.0,
                      ),
                      Expanded(
                        child: Text(
                          '$lastUpdated',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Minecraft'),
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
                            dynamic decodedData =
                                await ServerData().getPlayersData();
                            updateUI(decodedData);
                          });
                        },
                        icon: Icon(Icons.refresh),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      IconButton(
                        onPressed: () {
                          Share.share('4geek.csrv.pl');
                        },
                        icon: Icon(Icons.share),
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
          )),
    );
  }
}
