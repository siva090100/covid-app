import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:covid_search/services/search.dart';
import 'package:covid_search/services/hyperlink.dart';
import 'package:covid_search/services/faq.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



//import 'package:http/http.dart';
//import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{
  Timer _debounce;
  TextEditingController search = TextEditingController();
  TabController _tabController;
  String s;
  String key='loading';
  List news;
  List myth;
  List questions;
  List similar;
  String title1='';
  String title2='';
  String title3='';
  String title4='';
  String update = 'True';
  bool isloading = false;
  String hit;
  String summary='';
   void result() async {
     setState(() {
       s = search.text;
     });
    Search instance = Search(search: '$s',upd:'$update');
    Faq faq = Faq();
    await instance.getResult();
    await faq.getResult();
    setState(() {
      key = '';
      news = instance.news;
      myth = instance.myth;
      similar = instance.similar;
      questions = faq.questions;
      summary = instance.summary;
      title1 = 'News';
      title2 = 'Common Myths';
      title3 = 'FAQ';
      title4 = 'Similar Questions';
      isloading = false;
      hit = instance.hit;
      
    });
    if(hit=='True')
    setTimer();
     
   
    
   }
    void result1(String s) async {
     
    Search instance = Search(search: '$s',upd:'$update');
    Faq faq = Faq();
    await instance.getResult();
    await faq.getResult();
    setState(() {
      key = '';
      news = instance.news;
      myth = instance.myth;
      similar = instance.similar;
      questions = faq.questions;
      title1 = 'News';
      title2 = 'Common Myths';
      title3 = 'FAQ';
      title4 = 'Similar Questions';
      isloading = false;
      hit = instance.hit;
      
      
    });
    if(hit=='True')
    setTimer();
    
   }

   void setTimer()
   {
      Timer(Duration(seconds: 30), () {
        return showDialog<void>(
           barrierDismissible: true, 
           context: context,
            builder: (BuildContext context) {
             return AlertDialog(
                title: Text('The Search has been updated. Do you want to view it?'),
                actions: <Widget>[
                FlatButton(
                 child: Text('Yes'),
                  onPressed: () {
                     setState(() {
                        update = 'False';
                        isloading = true;
                      });
        
                      result1(s);
                      Navigator.pop(context);
                     },
                  ),
                FlatButton(
                 child: Text('No'),
                  onPressed: () {
                     Navigator.pop(context);
                     },
                  ),
             ],
             );
            },
      );
      });
   }


   launchURL(String url) {
     launch('$url');
   }


  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("COVID-19 Search"),
        backgroundColor: Colors.black87,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: Column( 
            
            children: <Widget> [
              Row( children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: TextFormField(
                    controller: search,
                    
                    onChanged: (String text) {
                      if (_debounce?.isActive ?? false) _debounce.cancel();
                      _debounce = Timer(const Duration(milliseconds: 1000), () {
                        
                      });
                    },
                    
                    decoration: InputDecoration(
                      hintText: "Search about Covid",
                      contentPadding: const EdgeInsets.only(left: 24.0),
                      border: InputBorder.none,
                    ),
                  ),
                  
                ),
              ),
              
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  isloading = true;
                  result();
                  search.clear();
                  
                  

                },
              ),
              
             
            
            ],
          ),
           
                
          TabBar(
                    controller: _tabController,
                    tabs: [ 
                    Tab(icon: Icon(Icons.search)),
                    Tab(icon: Icon(Icons.question_answer)),
                    ],
                  
                
                ),
            ],
          ),
         
         
        ),
         
      ),
      
      body: TabBarView(
      controller: _tabController,
      children:[
      ListView( 
        children: <Widget>[
          isloading?Center(
            child:SpinKitHourGlass(
             size: 50.0,
             color: Colors.black,
             //controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
          )):
         Center(
                    child: Card(
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('$summary',
                          style: TextStyle(
                          fontSize: 20.0,
                          
                    ),
                   ),
              ),
           ),
         ),
         Center(
          child: Text('$title1',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight:FontWeight.bold,
          ),
          ),),
        ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 300, minHeight: 56.0),
        child :ListView.builder(
        
        scrollDirection: Axis.horizontal,
        itemCount: news == null ? 0:news.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            height: 300.0,
            width: 400.0,
            child: Card(
            
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                 child: ListView(
                  children: <Widget>[
                  Center(
                    child: Hyperlink('${news[index]["source"].toString().replaceAll("[", "").replaceAll("]", "")}'),
                  ),
                   
                   Text("${news[index]["content"].toString().replaceAll("[", "").replaceAll("]", "")}",
                   style: TextStyle(
                     fontSize: 20.0,
                     
                   ),
                   
                   ),
                   
                    
                  ],
                 ),
            ),
            color: Colors.green[300],
          ),
        );
        },
        ),
        ),


        Divider(),


        Center(
          child: Text('$title2',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight:FontWeight.bold,
          ),
          ),),
        ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 300, minHeight: 56.0),
        child :ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: myth == null ? 0:myth.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            height: 300.0,
            width: 400.0,
            child: Card(
            
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: <Widget>[
                    Text('Claim:',
                       style: TextStyle(
                        fontSize: 20.0,
                        fontWeight:FontWeight.bold,
                  ),
                 ),
                   Text("${myth[index]["claim"].toString().replaceAll("[", "").replaceAll("]", "")}",
                   style: TextStyle(
                     fontSize: 20.0,
                     
                   ),
                   
                   ),
                   Divider(),
                   Text('Check:',
                       style: TextStyle(
                        fontSize: 20.0,
                        fontWeight:FontWeight.bold,
                    ),
                   ),
                   Text("${myth[index]["check"].toString().replaceAll("[", "").replaceAll("]", "")}",
                   style: TextStyle(
                     fontSize: 20.0,
                     
                   ),
                   
                   ),
                    
                  ],
                ),
            ),
            color: Colors.red[300],
          ),
        );
        },
        ),
        ),
       
        Divider(),
        Center(
          child: Text('$title4',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight:FontWeight.bold,
          ),
          ),),
        ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 150, minHeight: 56.0),
        child :ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: myth == null ? 0:similar.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            height: 300.0,
            width: 400.0,
            child: Card(
            
            child: InkWell(
                  onTap: () {
                         setState(() {
                        isloading = true; 
                        
                        });

                        _tabController.animateTo(0);
                        result1(similar[index].toString().replaceAll("[", "").replaceAll("]", ""));
                        search.text = similar[index].toString().replaceAll("[", "").replaceAll("]", "");
                    },
                  child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView(
                    children: <Widget>[
                      
                     Text("${similar[index].toString().replaceAll("[", "").replaceAll("]", "")}",
                     style: TextStyle(
                       fontSize: 20.0,
                       
                     ),
                     
                     ),
                     
                      
                    ],
                  ),
              ),
            ),
            color: Colors.blue[100],
          ),
        );
        },
        ),
        ),
        ],
    ),


      SingleChildScrollView(
        
              child: Column(
        children: <Widget>[
          isloading?Center(
            child:SpinKitHourGlass(
             size: 50.0,
             color: Colors.black,
             //controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
          )):
        Center(
            child: Text('$title3',
            style: TextStyle(
              fontSize: 30.0,
              
              color: Colors.indigoAccent,
              fontStyle: FontStyle.italic,
            ),
            ),),  
        Divider(),  
         ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 500, minHeight: 56.0),
          child : ListView.builder(
          
          itemCount: myth == null ? 0:questions.length,
          itemBuilder: (BuildContext context, int index){
            return Container(
              height: 100.0,
              width: 400.0,
              child: Card(
              
              child: InkWell(
                      onTap: () {
                        setState(() {
                        isloading = true;  
                        
                        });
                        
                        _tabController.animateTo(0);
                        result1(questions[index].toString().replaceAll("[", "").replaceAll("]", ""));
                        search.text = questions[index].toString().replaceAll("[", "").replaceAll("]", "");
                    },
                     child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("${questions[index].toString().replaceAll("[", "").replaceAll("]", "")}",
                       style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        ),
                      ),
                      
                    ),
              ),
               
              color: Colors.blue[50],
              ),
            );
          },
         ),
         ),
        ],
        ),
      ),


      ],
      ),
      
    );
  }

  
}
