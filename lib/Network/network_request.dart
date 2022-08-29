import 'dart:convert';
import '../Model/authorObject.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

Future<List<Data>> fetchAuthors() async{
  //Isolates.spawn();

  var url = Uri.parse("https://inshorts.deta.dev/news?category=all");
  final response = await http.get(url);

  if(response.statusCode == 200){
    return compute(parseAuthor,response.body);
  }else{
    throw Exception("Can't get Data");
  }

}

List<Data> parseAuthor(String responseBody){
  AuthorObject objects = AuthorObject.fromJson(json.decode(responseBody));
  if (kDebugMode) {
    print(objects.data);
  }
  List<Data> dataList = [];
  try{
    dataList.addAll(objects.data as List<Data>);
  }catch(e){
    print(e);
  }
  return dataList ;
}