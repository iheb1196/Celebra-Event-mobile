

import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:math';

import 'package:flutter_login_signup/src/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Config config;

  AuthService(){
    config = new Config();
  }

  Future<String> logOut() async{
    final SharedPreferences sp = await _prefs;
    sp.remove('token');
  }


  Future<String> setAccessToken(String token) async{
    final SharedPreferences sp = await _prefs;
    sp.setString('token', token);
  }

  Future<bool> isConnected() async{
    final SharedPreferences sp = await _prefs;

    if(sp.get('token')==null){
      return false;
    }
    return true;
  }

  Future<String> getAccessToken() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.get('token');
  }



  Future<Map> authUser(String email, String password) async {
    HttpClient httpClient = new HttpClient();

    try{
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(config.domain+'/userAuth'));
      request.headers.set('content-type', 'application/json');

      request.add(utf8.encode(json.encode({
        "email":email,
        "password":password
      })));
      HttpClientResponse response = await request.close();
      // todo - you should check the response.statusCode

      String reply = await response.transform(utf8.decoder).join();
      Map res = json.decode(reply);
      return res;
    }catch (e){
      return json.decode('{ "success":"false","message":"Please, check your internet connection and try again." }' );
    }

  }


  Future<Map> createUser(String email, String password, String fullname) async {
    HttpClient httpClient = new HttpClient();

    try{
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(config.domain+'/userCreate'));
      request.headers.set('content-type', 'application/json');

      request.add(utf8.encode(json.encode({
        "email":email,
        "fullname": fullname,
        "password":password
      })));
      HttpClientResponse response = await request.close();
      // todo - you should check the response.statusCode

      String reply = await response.transform(utf8.decoder).join();
      Map res = json.decode(reply);
      print(res);
      return res;
    }catch (e){
      return json.decode('{ "success":"false","message":"Please, check your internet connection and try again." }' );
    }
  }


  Future<Map> infoUser() async {
    HttpClient httpClient = new HttpClient();
    final SharedPreferences sp = await _prefs;

    try{
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(config.domain+'/userInfo'));
      request.headers.set('content-type', 'application/json');
      request.headers.set('authorization',  sp.getString('token'));

      HttpClientResponse response = await request.close();
      // todo - you should check the response.statusCode

      String reply = await response.transform(utf8.decoder).join();
      Map res = json.decode(reply);
      print(res);
      return res;
    }catch (e){
      return json.decode('{ "success":"false","message":"Please, check your internet connection and try again." }' );
    }
  }


}