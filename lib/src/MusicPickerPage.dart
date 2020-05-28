import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_login_signup/src/PhotographerPickerPage.dart';
import 'package:flutter_login_signup/src/Widget/bezierContainer.dart';
import 'package:flutter_login_signup/src/loginPage.dart';
import 'package:flutter_login_signup/src/services/EventsService.dart';
import 'package:flutter_login_signup/src/services/authService.dart';
import 'package:flutter_login_signup/src/services/config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';

class MusicPickerPage extends StatefulWidget {
  double budget;
  String title;
  String date;
  String eventType;
  String eventLocationValue;


  MusicPickerPage( String title,String date,double budget, String eventType,eventLocationValue  ){

    this.budget=budget;
    this.title=title;
    this.eventType=eventType;
    this.date=date;
    this.eventLocationValue=eventLocationValue;
  }


  @override
  _MusicPickerPageState createState() => _MusicPickerPageState(budget,title,date,eventType,eventLocationValue);
}

class _MusicPickerPageState extends State<MusicPickerPage> {
  Config c = new Config();

  double budget;
  String title;
  String date;
  String eventType;
  String eventLocationValue;


  ProgressDialog pr;

  String _eventLocationValue="";

  List<Widget> _eventsLocationsOptions =[];
  Map _loactionMap = new Map();



  _MusicPickerPageState(double budget, title, date, eventType, eventLocationValue){
    this.budget=budget;
    this.title=title;
    this.eventType=eventType;
    this.date=date;
    this.eventLocationValue=eventLocationValue;


    _getEventLocationsList();

  }



  Widget _getImagesWidgets(c){
    List<Widget> _tmp = new List();

    for(int i=0;i<_loactionMap['images'].length;i++){
      String url =_loactionMap['images'][i];

      url=url.replaceAll('http://localhost:3000', this.c.domain);

      _tmp.add(
          Container(
            height: 90,
            margin: EdgeInsets.all(5),
            child: Image.network(url),
          )
      );
    }

    return Container(
      width: MediaQuery.of(c).size.width ,
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:
        _tmp

        ,
      ),
    );
  }



  _updateOptionAfterSelect() async{
    EventsService events= new EventsService();


    Map res = await events.getEventMusicList(eventType);
    if(res['success']==true){

      //set the locations data to a global variable;


      List<Widget> _tmp = new List<Widget>();
      for(int i=0;i<res['music'].length;i++  ){
        if(res['music'][i]['price'] < budget ){
          _tmp.add(
            RadioListTile(
              title: Text(res['music'][i]['name']),
              value: res['music'][i]['_id'].toString(),
              groupValue: _eventLocationValue,
              onChanged: (String data) async {
                _eventLocationValue=data;
                _updateOptionAfterSelect();

              },
            ),
          );
        }
      }
      for(int i=0;i<res['music'].length;i++){
        if(res['music'][i]['key']==_eventLocationValue){
          setState(() {
            _loactionMap=res['music'][i];
          });
          break;
        }
      }
      setState(() {
        _eventsLocationsOptions=_tmp;
      });
    }else{
      Navigator.of(context).pop();
    }


  }

  _getEventLocationsList() async{
    EventsService events= new EventsService();
    Map res = await events.getEventMusicList(eventType);
    if(res['success']==true){
      setState(() {
        _eventLocationValue=res['music'][0]['_id'].toString();
        _loactionMap=res['music'][0];

      });


      List<Widget> _tmp = new List<Widget>();
      for(int i=0;i<res['music'].length;i++  ){
        if(res['music'][i]['price'] < budget ){
          _tmp.add(
            RadioListTile(
              title: Text(res['music'][i]['name'].toString()),
              value: res['music'][i]['_id'].toString(),
              groupValue: _eventLocationValue,
              onChanged: (String data) async {
                _eventLocationValue=data;
                _updateOptionAfterSelect();

              },
            ),
          );
        }

      }
      setState(() {
        _eventsLocationsOptions=_tmp;
      });
    }else{
      Navigator.of(context).pop();
    }





  }










  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }




  Widget _submitButton(c) {
    return GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width / 2 -30,
          padding: EdgeInsets.symmetric(vertical: 15),
          margin: EdgeInsets.only(left: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xfffbb448), Color(0xfff7892b)])),
          child: Text(
            'NEXT',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        onTap: () async {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => PhotographerPickerPage(title,date,( budget - _loactionMap['price'] ),eventType,eventLocationValue,_eventLocationValue))) ;

        }
    );
  }

  Widget _previousButton(c) {
    return GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width / 2 -30,
          padding: EdgeInsets.symmetric(vertical: 15),
          margin: EdgeInsets.only(left: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.grey.shade700, Colors.black])),
          child: Text(
            'BACK',
            style: TextStyle(fontSize: 20, color: Colors.orangeAccent),
          ),
        ),
        onTap: () async {
          Navigator.of(context).pop();
        }
    );
  }

  Future<void> _showLoading() async{
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal,
        isDismissible: false,
        showLogs: false);
    pr.style(
        message: 'Please wait...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        messageTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 13.0,
            fontWeight: FontWeight.w600));

    await pr.show();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: ListView(
            children :<Widget>[
              Container(
                height: MediaQuery.of(context).size.height-30,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 150,
                          ),

                          Text(

                            'current buget ${budget}TND',textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text('What about the music ?',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),

                          Column(
                              children: _eventsLocationsOptions),
                          _eventLocationValue != '' && _eventsLocationsOptions.length!=0 ? Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Price : ${_loactionMap['price']} TND'),
                                Text('Location  : ${_loactionMap['location']} ')

                              ],
                            ),
                          ) : Container() ,
                          SizedBox(
                            height: 15,
                          ),
                          _eventLocationValue != '' && _eventsLocationsOptions.length!=0 ? _getImagesWidgets(context) : Container() ,
                          SizedBox(
                            height: 15,
                          ),



                          Row(
                            children: <Widget>[
                              _previousButton(context),
                              _eventLocationValue != '' && _eventsLocationsOptions.length!=0 ? _submitButton(context) : Container() ,

                            ],
                          ),





                          Expanded(
                            flex: 2,
                            child: SizedBox(),
                          )
                        ],
                      ),
                    ),
                    Positioned(top: 40, left: 0, child: _backButton()),
                    Positioned(
                        top: -MediaQuery.of(context).size.height * .15,
                        right: -MediaQuery.of(context).size.width * .4,
                        child: BezierContainer())
                  ],
                ),

              )]    )
    );

  }
}
