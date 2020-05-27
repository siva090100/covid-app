
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
    Map data =jsonDecode(response.body);
     myth = data['Common Myths'];
     news = data['News'];
     
    

    
    // get properties from json
    
    
    

    

  }

}

