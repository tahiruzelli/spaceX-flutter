// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomTextButton extends StatelessWidget {
  String content;
  String _url;
  CustomTextButton(this.content, this._url);
  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _launchURL();
      },
      child: Container(
        width: 300,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey[200],
                Colors.white,
                Colors.grey[200],
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 5,
                spreadRadius: 1,
                color: Colors.grey[500],
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Center(
            child: Text(
              content,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
