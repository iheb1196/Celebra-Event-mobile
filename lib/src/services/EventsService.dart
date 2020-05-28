

import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:math';

import 'package:flutter_login_signup/src/services/authService.dart';
import 'package:flutter_login_signup/src/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EventsService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Config config;

  EventsService(){
    config = new Config();
  }

  Future<Map> getEventsTypes() async {
    HttpClient httpClient = new HttpClient();
    final SharedPreferences sp = await _prefs;

    try{
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(config.domain+'/eventsList'));
      request.headers.set('content-type', 'application/json');
      request.headers.set('authorization',  sp.getString('token'));

      HttpClientResponse response = await request.close();
      // todo - you should check the response.statusCode

      String reply = await response.transform(utf8.decoder).join();
      Map res = json.decode(reply);
      return res;
    }catch (e){
      print(e.toString());
      return json.decode('{ "success":"false","message":"Please, check your internet connection and try again." }' );
    }
  }


  Future<Map> getEventsLocationsTypes(String id) async {
    HttpClient httpClient = new HttpClient();
    final SharedPreferences sp = await _prefs;

    try{
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(config.domain+'/eventsLocations?idEvent='+id));
      request.headers.set('content-type', 'application/json');
      request.headers.set('authorization',  sp.getString('token'));

      HttpClientResponse response = await request.close();
      // todo - you should check the response.statusCode

      String reply = await response.transform(utf8.decoder).join();
      Map res = json.decode(reply);
      return res;
    }catch (e){
      print(e.toString());
      return json.decode('{ "success":"false","message":"Please, check your internet connection and try again." }' );
    }
  }


  Future<Map> getEventMusicList(String id) async {
    HttpClient httpClient = new HttpClient();
    final SharedPreferences sp = await _prefs;

    try{
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(config.domain+'/eventsMusic?idEvent='+id));
      request.headers.set('content-type', 'application/json');
      request.headers.set('authorization',  sp.getString('token'));

      HttpClientResponse response = await request.close();
      // todo - you should check the response.statusCode

      String reply = await response.transform(utf8.decoder).join();
      Map res = json.decode(reply);
      return res;
    }catch (e){
      print(e.toString());
      return json.decode('{ "success":"false","message":"Please, check your internet connection and try again." }' );
    }
  }

  Future<Map> getEventPhotographgerList(String id) async {
    HttpClient httpClient = new HttpClient();
    final SharedPreferences sp = await _prefs;

    try{
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(config.domain+'/EventsPhotography?idEvent='+id));
      request.headers.set('content-type', 'application/json');
      request.headers.set('authorization',  sp.getString('token'));

      HttpClientResponse response = await request.close();
      // todo - you should check the response.statusCode

      String reply = await response.transform(utf8.decoder).join();
      Map res = json.decode(reply);
      return res;
    }catch (e){
      print(e.toString());
      return json.decode('{ "success":"false","message":"Please, check your internet connection and try again." }' );
    }
  }


  Future<Map> getEventMakeupList(String id) async {
    HttpClient httpClient = new HttpClient();
    final SharedPreferences sp = await _prefs;

    try{
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(config.domain+'/EventsBeauty?idEvent='+id));
      request.headers.set('content-type', 'application/json');
      request.headers.set('authorization',  sp.getString('token'));

      HttpClientResponse response = await request.close();
      // todo - you should check the response.statusCode

      String reply = await response.transform(utf8.decoder).join();
      Map res = json.decode(reply);
      return res;
    }catch (e){
      print(e.toString());
      return json.decode('{ "success":"false","message":"Please, check your internet connection and try again." }' );
    }
  }


  Future<Map> confirmEvent(String id) async {
    HttpClient httpClient = new HttpClient();
    final SharedPreferences sp = await _prefs;

    try{
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(config.domain+'/confirmEvent?idEvent='+id));
      request.headers.set('content-type', 'application/json');
      request.headers.set('authorization',  sp.getString('token'));

      HttpClientResponse response = await request.close();
      // todo - you should check the response.statusCode

      String reply = await response.transform(utf8.decoder).join();
      Map res = json.decode(reply);
      return res;
    }catch (e){
      print(e.toString());
      return json.decode('{ "success":"false","message":"Please, check your internet connection and try again." }' );
    }
  }

  Future<Map> deleteEvent(String id) async {
    HttpClient httpClient = new HttpClient();
    final SharedPreferences sp = await _prefs;

    try{
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(config.domain+'/deleteEvent?idEvent='+id));
      request.headers.set('content-type', 'application/json');
      request.headers.set('authorization',  sp.getString('token'));

      HttpClientResponse response = await request.close();
      // todo - you should check the response.statusCode

      String reply = await response.transform(utf8.decoder).join();
      Map res = json.decode(reply);
      return res;
    }catch (e){
      print(e.toString());
      return json.decode('{ "success":"false","message":"Please, check your internet connection and try again." }' );
    }
  }


  Future<Map> getEventDetails(String id) async {
    HttpClient httpClient = new HttpClient();
    final SharedPreferences sp = await _prefs;

    try{
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(config.domain+'/myEventDetails?idEvent='+id));
      request.headers.set('content-type', 'application/json');
      request.headers.set('authorization',  sp.getString('token'));

      HttpClientResponse response = await request.close();
      // todo - you should check the response.statusCode

      String reply = await response.transform(utf8.decoder).join();
      Map res = json.decode(reply);
      return res;
    }catch (e){
      print(e.toString());
      return json.decode('{ "success":"false","message":"Please, check your internet connection and try again." }' );
    }
  }



  Future<Map> getEventDressingList(String id) async {
    HttpClient httpClient = new HttpClient();
    final SharedPreferences sp = await _prefs;

    try{
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(config.domain+'/EventsWearing?idEvent='+id));
      request.headers.set('content-type', 'application/json');
      request.headers.set('authorization',  sp.getString('token'));

      HttpClientResponse response = await request.close();
      // todo - you should check the response.statusCode

      String reply = await response.transform(utf8.decoder).join();
      Map res = json.decode(reply);
      return res;
    }catch (e){
      print(e.toString());
      return json.decode('{ "success":"false","message":"Please, check your internet connection and try again." }' );
    }
  }

  Future<Map> getEventsList() async {
    HttpClient httpClient = new HttpClient();
    final SharedPreferences sp = await _prefs;

    try{
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(config.domain+'/myEventsList'));
      request.headers.set('content-type', 'application/json');
      request.headers.set('authorization',  sp.getString('token'));

      HttpClientResponse response = await request.close();
      // todo - you should check the response.statusCode

      String reply = await response.transform(utf8.decoder).join();
      Map res = json.decode(reply);
      return res;
    }catch (e){
      print(e.toString());
      return json.decode('{ "success":"false","message":"Please, check your internet connection and try again." }' );
    }
  }




  Future<Map> createEvent(String eventTitle, String eventTypeId, String eventDate,String eventLocationId , String eventMusicId,String eventPhotographId,
      String eventBeautyId,String eventWearingId
      ) async {
    HttpClient httpClient = new HttpClient();
    final SharedPreferences sp = await _prefs;

    try{
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(config.domain+'/eventCreate'));
      request.headers.set('content-type', 'application/json');
      request.headers.set('authorization',  sp.getString('token'));

      request.add(utf8.encode(json.encode({
        "name":eventTitle,
        "evnetTypeId": eventTypeId,
        "date": eventDate,
        "eventLocationId": eventLocationId,
        "eventMusicId": eventMusicId,
        "eventPhotographId": eventPhotographId,
        "eventBeautyId": eventBeautyId,
        "eventWearingId": eventWearingId,
        "uid":sp.getString('token'),
        "adddate": new DateTime.now().toString(),
        "stat":0
      })));
      HttpClientResponse response = await request.close();
      // todo - you should check the response.statusCode

      String reply = await response.transform(utf8.decoder).join();
      Map res = json.decode(reply);
      print(res);
      return res;
    }catch (e){
      print(e);
      return json.decode('{ "success":"false","message":"Please, check your internet connection and try again." }' );
    }

  }

}