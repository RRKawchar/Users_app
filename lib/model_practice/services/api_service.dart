import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart'as http;
import 'package:users_app/model_practice/image_url.dart';
import 'package:users_app/model_practice/model/porduct.dart';
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
  }


