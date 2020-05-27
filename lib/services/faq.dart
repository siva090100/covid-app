import 'package:http/http.dart';
import 'dart:convert';
//import 'dart:io';

class Faq {

   // location name for UI
  List questions;
  
  

  

  Future<void> getResult() async {
    // make the request
    Response response = await get('https://covidsearchtest.herokuapp.com/query/faq');
    Map data =jsonDecode(response.body);
    questions = data['faqs'];
    print(questions);
  }
}