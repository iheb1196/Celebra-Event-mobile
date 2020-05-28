import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Widget/bezierContainer.dart';
import 'package:flutter_login_signup/src/loginPage.dart';
import 'package:flutter_login_signup/src/services/EventsService.dart';
import 'package:flutter_login_signup/src/services/authService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';

class DetailsEventPage extends StatefulWidget {
  String id;
  DetailsEventPage(String id){
    this.id=id;
  }


  @override
  _PageState createState() => _PageState(id);
}

class _PageState extends State<DetailsEventPage> {

  String _id;
  Map _event = new Map();
  _PageState(String id){
    this._id=id;

    _getEventData();
  }

  bool _isLoading=true;
  EventsService es = new EventsService();



  Future<void> _getEventData() async{
    es.getEventDetails(_id).then((Map data){
      setState(() {
        _isLoading=false;
        _event = data['event'][0];
      });
    }).catchError((error){
      Navigator.of(context).pop();
    });
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






  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading == false ? ListView(
          children: <Widget>[
            _backButton(),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Text('${_event['name']}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25), )
              ,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Text('N° : ${_event['_id']}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15), )
              ,
            ),

            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Text('Event date : ${_event['date']} ',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18), )
              ,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Text('Created at : ${ _event['adddate'].substring(0,10)} ',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18), )
              ,
            ),

            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Text('Details',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 18), )
              ,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Table(border: TableBorder.all(color: Colors.orangeAccent,width: 1,style: BorderStyle.solid),
                children: [
                  TableRow(
                      children: [
                        TableCell(child: Center(child: Text('Description',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 15),),),),
                        TableCell(child: Center(child: Text('Price',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 15)),),),

                      ]
                  ),
                  TableRow(
                      children: [
                        TableCell(child: Text(_event['eventMusicDeatils'][0]['name'].toString(),textAlign: TextAlign.center, ),),
                        TableCell(child: Text('${_event['eventMusicDeatils'][0]['price'].toString()} TND' ,textAlign: TextAlign.center,),),

                      ]
                  ),
                  TableRow(
                      children: [
                        TableCell(child: Text(_event['beautyDeatils'][0]['name'].toString(),textAlign: TextAlign.center,),),
                        TableCell(child: Text('${_event['beautyDeatils'][0]['price'].toString()} TND',textAlign: TextAlign.center,),),

                      ]
                  ),
                  TableRow(
                      children: [
                        TableCell(child: Text(_event['photographerDeatils'][0]['name'].toString(),textAlign: TextAlign.center,),),
                        TableCell(child: Text('${_event['photographerDeatils'][0]['price'].toString()} TND' ,textAlign: TextAlign.center,),),

                      ]
                  ),
                  TableRow(
                      children: [
                        TableCell(child: Text(_event['locationDeatils'][0]['name'].toString(),textAlign: TextAlign.center,),),
                        TableCell(child: Text('${_event['locationDeatils'][0]['price'].toString()} TND',textAlign: TextAlign.center,),),

                      ]
                  ),
                  TableRow(
                      children: [
                        TableCell(child: Text(_event['eventWearingDetails'][0]['name'].toString(),textAlign: TextAlign.center,),),
                        TableCell(child: Text('${_event['eventWearingDetails'][0]['price'].toString()} TND',textAlign: TextAlign.center,),),

                      ]
                  ),
                  TableRow(
                      children: [
                        TableCell(child: Center(child: Text('Total',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 15),),),),
                        TableCell(child: Text(
                          ' ${
                              (_event['locationDeatils'][0]['price']+_event['photographerDeatils'][0]['price']+_event['beautyDeatils'][0]['price']
                                  +_event['eventMusicDeatils'][0]['price']+_event['eventWearingDetails'][0]['price']).toString()
                          } TND',textAlign: TextAlign.center,style: TextStyle(fontSize: 20),
                        ) ),

                      ]
                  ),


                ]
              )
              ,
            ),




          ],
        ):
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text('Loading...',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700), textAlign: TextAlign.center,),
                )
              ],

            )
    );
  }
}
