import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart'as http;
import 'package:users_app/model_practice/image_url.dart';
import 'package:users_app/model_practice/model/porduct.dart';
import 'package:users_app/model_practice/user.dart';
class ApiService {

  Future<List<Product>?> getUsers() async {
  try {
  var url = Uri.parse(firstApi);
  var response = await http.get(url);
  if (response.statusCode == 200) {
  List<Product> _model = productFromJson(response.body);
  return _model;
  }
  } catch (e) {
  log(e.toString());
  }
  }

  List<Users> userList=[];
  Future<List<Users>> UserApi()async{
    final response=await http.get(Uri.parse("https://fakestoreapi.com/users"));
    var data=jsonDecode(response.body.toString());

    if(response.statusCode==200){
      for(Map i in data){
        userList.add(Users.fromJson(i));
      }
      return userList;
    }else{
      return userList;
    }
  }


  List<Product> postList=[];
  Future<List<Product>> getPostApi()async{
    final response=await http.get(Uri.parse("https://fakestoreapi.com/products"));
    var data=jsonDecode(response.body.toString());

    if(response.statusCode==200){
      for(Map i in data){
        postList.add(Product.fromJson(i));
      }
      return postList;
    }else{
      return postList;
    }
  }

  }


