import 'package:flutter/material.dart';

import 'pages/home.dart';

//import 'package:world_time_app/pages/loading.dart';


void main() => runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      //'/': (context) => Loading(),
      '/home': (context) => Home(),
      
    }
));

