
import 'package:http/http.dart';
import 'dart:convert';
//import 'dart:io';

class Search {

  String search; // location name for UI
  List myth;
  List news;
  

  Search({this.search});

  Future<void> getResult() async {
    // make the request
    Response response = await get('https://covidsearchtest.herokuapp.com/query/search/?query=$search');
    Map data = jsonDecode(response.body);
     myth = data['Common Myths'];
     news = data['News'];
     print(news);

    
    // get properties from json
    
    
    

    // create DateTime object
    //DateTime now = DateTime.parse(datetime);
    //now = now.add(Duration(hours: int.parse(offset)));

    

    // set the time property

  }

}

