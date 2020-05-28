import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/LocationPickerPage.dart';
import 'package:flutter_login_signup/src/Widget/bezierContainer.dart';
import 'package:flutter_login_signup/src/loginPage.dart';
import 'package:flutter_login_signup/src/services/EventsService.dart';
import 'package:flutter_login_signup/src/services/authService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';

class NewEventPage extends StatefulWidget {
  NewEventPage({Key key}) : super(key: key);


  @override
  _NewEventPageState createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {

  TextEditingController _eventTitleController = new TextEditingController();

  TextEditingController _eventDateController = new TextEditingController();
  TextEditingController _eventpriceController = new TextEditingController();


  List<Widget> _eventsOptions=[];


  DateTime _eventDate = DateTime.now();

  String _eventValue="";

  _NewEventPageState(){
    _eventDateController.value = new TextEditingValue(text: _eventDate.toString().substring(0,10));
    _eventTitleController.value = new TextEditingValue(text:'My super event');
    _eventpriceController.value = new TextEditingValue(text:'0');

    _getEventList(context);

  }


  _updateOptionAfterSelect() async{
    EventsService events= new EventsService();


    Map res = await events.getEventsTypes();
    print(res);

    if(res['success']==true){


      List<Widget> _tmp = new List<Widget>();
      for(int i=0;i<res['events'].length;i++  ){
        _tmp.add(
          RadioListTile(
            title: Text(res['events'][i]['name'].toString()),
            value: res['events'][i]['_id'].toString(),
            groupValue: _eventValue,
            onChanged: (String data) async {
              print(data);
              _eventValue=data;
              _updateOptionAfterSelect();

            },
          ),
        );
      }
      setState(() {
        _eventsOptions=_tmp;
      });
    }else{
      Navigator.of(context).pop();
    }


  }

  _getEventList(c) async{
    EventsService events= new EventsService();

    ProgressDialog pr = new ProgressDialog(c,
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

   /* await pr.show();*/

    Map res = await events.getEventsTypes();
    print(res);

    if(res['success']==true){
      setState(() {
        _eventValue=res['events'][0]['_id'].toString();
      });


      List<Widget> _tmp = new List<Widget>();
      for(int i=0;i<res['events'].length;i++  ){
        _tmp.add(
             RadioListTile(
               title: Text(res['events'][i]['name'].toString()),
              value: res['events'][i]['_id'].toString(),
              groupValue: _eventValue,
              onChanged: (String data) async {
                print(data);
                  _eventValue=data;
                _updateOptionAfterSelect();

              },
            ),
        );
      }
      setState(() {
        _eventsOptions=_tmp;
      });
    }else{
      Navigator.of(context).pop();
    }





  }



  Future<Null> _selectStartDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _eventDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _eventDate)
      _eventDateController.value = new TextEditingValue(text: picked.toString().substring(0,10));
      setState(() {
        _eventDate = picked;

      });
  }


  Widget _eventTitleField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: _eventTitleController,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _eventDateField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            onTap: (){
              _selectStartDate(context);
            },
              controller: _eventDateController,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _eventPriceField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              keyboardType: TextInputType.number,
              controller: _eventpriceController,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
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
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
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
            MaterialPageRoute(builder: (context) => LocationPickerPage(_eventTitleController.text,_eventDateController.text,double.parse(_eventpriceController.text) ,_eventValue )));
      }



    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
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

                          'Welcome to \nevents creator wizzard\nI\'ll guide you throug your event creation\nproccess, let\'s go!',textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text('So what\'s in your mind ?',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),),

                        _eventTitleField('Event title'),

                        _eventDateField('Event date '),
                        _eventPriceField('Event budget (TND) '),

                        Text(
                          'Event Type',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Column(
                          children: _eventsOptions),





                        _submitButton(context),
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
            )));
  }
}
