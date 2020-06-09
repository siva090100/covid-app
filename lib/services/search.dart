
import 'package:http/http.dart';
import 'dart:convert';
//import 'dart:io';

class Search {

  String search;
  String upd;
  List myth;
  List news;
  List similar;
  dynamic summary;
  String hit;
  Search({this.search,this.upd});

  Future<void> getResult() async {
    // make the request
    Response response = await get('https://covidsearchtest.herokuapp.com/query/search/?query=$search&&update=$upd');
    Map data =jsonDecode(response.body);
     myth = data['Common Myths'];
     news = data['News'];
     similar = data['similar_questions'];
     summary = data ['summary'];
     hit = data['hit_again'];
     
    

    
    // get properties from json
    
    
    

    

  }

}

