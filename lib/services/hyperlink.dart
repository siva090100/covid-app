import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class Hyperlink extends StatelessWidget {
  final String _url;
  

  Hyperlink(this._url);

  _launchURL() async {
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        'Click here to open source',
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontSize: 20.0,
          color: Colors.blue[900],
          ),
      ),
      onTap: _launchURL,
    );
  }
}