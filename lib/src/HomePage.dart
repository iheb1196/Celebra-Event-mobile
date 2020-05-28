import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/DetailsEventPage.dart';
import 'package:flutter_login_signup/src/NewEventPage.dart';
import 'package:flutter_login_signup/src/loginPage.dart';
import 'package:flutter_login_signup/src/services/EventsService.dart';
import 'package:flutter_login_signup/src/services/authService.dart';
import 'package:flutter_login_signup/src/signup.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);



  @override
  _HomePageState createState() => _HomePageState();



}

class _HomePageState extends State<HomePage> {
  AuthService auth;
  String _fullname="Loading...";
  String _email="Loading...";


  List<Widget> _events = new List<Widget>();

  _HomePageState(){
    auth = new AuthService();
    auth.infoUser();
    getUserInfo();
    refreshEventsList();
  }

  getUserInfo() async{
    Map res = await auth.infoUser();
    setState(() {
      _fullname=res['user']['fullname'];
      _email=res['user']['email'];
    });
  }

  Future<void> _getEventsList() async{
    EventsService events = new EventsService();
    Map res = await events.getEventsList();
    List tmp = new List<Widget>();

    for(Map event in res['events']){
      tmp.add(_eventCard(event['_id'], event['stat'], event['name'], event['date'], event['adddate']));

    }

    setState(() {
      _events=tmp;
    });


    print(res);

  return false;
  }

  refreshEventsList() async{
    EventsService events = new EventsService();
    Map res = await events.getEventsList();
    List tmp = new List<Widget>();

    for(Map event in res['events']){
      print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh ${event['stat'] }');
      tmp.add(_eventCard(event['_id'], event['stat'], event['name'], event['date'], event['adddate']));
    }
    setState(() {
      _events=tmp;
    });
    return false;
  }





  _logout(c){
    showDialog(context: c,builder: (_)=> AlertDialog(
      title: Text('LOG OUT'),
      content: Text('Do you really wanna logout ?'),
      actions: <Widget>[
        FlatButton(
          child: Text('NO'),
          onPressed: (){
            Navigator.of(c).pop();
          },
        ),
        FlatButton(
          child: Text('YES'),
          onPressed: () async{
            Navigator.of(c).pop();
            AuthService auth = new AuthService();
            await auth.logOut();
            Navigator
                .of(c)
                .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => LoginPage()));

          },
        )

      ],
    ));
  }


  Widget _eventCard(String id, int stat, String eventTitle,String startdate,String creationDate){
   return (
       GestureDetector(
         onTap: (){
           print("to details page $id ");
         },
         child: Card(

           margin: EdgeInsets.only(left: 15,right: 15,top: 20),
           child: Container(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Text(eventTitle,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w800),),
                 Text('N°:$id',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w800),),

                 Row(
                   children: <Widget>[
                     Icon(Icons.calendar_today,size: 18,color: Colors.grey,),Text('creation date : ${creationDate.substring(0,10)} ',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300,color: Colors.grey.shade600),),
                   ],
                 ),
                 Row(
                   children: <Widget>[
                     Icon(Icons.calendar_today,size: 18,color: Colors.grey,),Text('event date : $startdate ',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w300,color: Colors.grey.shade600),),
                   ],
                 ),

                 SizedBox(
                   height: 10,
                 ),

                 Row(
                   children: <Widget>[
                     stat == 0 ? FlatButton(
                       child: Text('CONFIRM'),
                       onPressed: (){
                         showDialog(context: context,builder: (_)=>AlertDialog(
                           title: Text('CONFIRM'),
                           content: Text('Do you really wanna conform this event ?.'),
                           actions: <Widget>[
                             FlatButton(
                               child: Text('NO'),
                               onPressed: (){
                                 Navigator.of(context).pop();
                               },
                             ),
                             FlatButton(
                               child: Text('YES'),
                               onPressed: (){
                                 Navigator.of(context).pop();
                                  EventsService es = new EventsService();
                                  es.confirmEvent(id).then((data){
                                    refreshEventsList();
                                  });
                               },
                             ),

                           ],

                         ));
                       },
                       color: Colors.orange.shade50,
                     ): SizedBox(),

                     stat == 0 ? Container(
                       margin: EdgeInsets.only(left: 10),
                       child: FlatButton(
                         child: Text('DELETE'),
                         onPressed: (){
                           showDialog(context: context,builder: (_)=>AlertDialog(
                             title: Text('DELETE'),
                             content: Text('Do you really wanna delete this event ?.'),
                             actions: <Widget>[
                               FlatButton(
                                 child: Text('NO'),
                                 onPressed: (){
                                   Navigator.of(context).pop();
                                 },
                               ),
                               FlatButton(
                                 child: Text('YES',style: TextStyle(color: Colors.redAccent),),
                                 onPressed: (){
                                   Navigator.of(context).pop();
                                   EventsService es = new EventsService();
                                   es.deleteEvent(id).then((data){
                                     refreshEventsList();
                                   });
                                 },
                               ),

                             ],

                           ));
                         },
                         color: Colors.red.shade50,
                       ),
                     ):Container(

                       child: FlatButton(
                         child: Text( 'DETAILS' ),
                         onPressed: (){
                            Navigator.push(context,new MaterialPageRoute(builder: (context)=> DetailsEventPage(id)));
                         },
                         color: Colors.green.shade50,
                       ),
                     ),




                   ],
                 ),




               ],
             ),
             padding: EdgeInsets.all(15),
           ),
         ),
       )
   );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewEventPage()));
        },
      ),
      appBar: AppBar(
        title: Text('Celebra Events'),
      ),
      drawer: Drawer(
        child: Container(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      radius: 30,
                    ),
                    Text(_fullname,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w600),),
                    Text(_email,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.grey.shade400),)
                  ],
                ),
              ),
              ListTile(
                trailing: Icon(Icons.event,color: Colors.orangeAccent,),
                title: Text('My events'),
                onTap: (){
                  Navigator.of(context).pop();

                },
              ),
              ListTile(
                trailing: Icon(Icons.exit_to_app,color: Colors.redAccent),
                title: Text('Log out'),
                onTap: (){
                  Navigator.of(context).pop();
                  _logout(context);
                },
              )
            ],
          ),
        )
      ),
      body: RefreshIndicator(
        onRefresh: _getEventsList,
        child: ListView(
          children: _events
        ),
      ),
    );

  }
}
