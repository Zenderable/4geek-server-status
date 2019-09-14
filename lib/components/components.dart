import 'package:flutter/material.dart';

class Logos extends StatelessWidget {
  Logos({this.image, this.margin});
  final String image;
  final EdgeInsets margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Image.asset(image),
    );
  }
}

class PlayersList extends StatelessWidget {
  final String data;
  PlayersList({this.data});
  @override
  Widget build(BuildContext context) {
    return Text(data);
  }
}
