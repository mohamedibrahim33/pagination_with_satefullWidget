import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pagination/constant.dart';

import 'api_model.dart';

class CharactersServices {
  late Dio dio;
  CharactersServices(){
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 20*1000,
        receiveTimeout: 20*1000,
      ),
    );
  }
  Future<List<Character>> fetchData(int offset) async {
    try {
      var response = await dio.get(offset.toString());
      print(response.data);
      List<Character> characters=[];
      var list = response.data;
      for(var item in list){
        characters.add(Character.fromJson(item));
      }
      print(characters.length);
       return characters;

    } catch (e) {
      return[];
    }
  }
}




