import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:users_app/model_practice/image_url.dart';
import 'package:users_app/model_practice/model/porduct.dart';
import 'package:users_app/model_practice/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:users_app/model_practice/user.dart';
class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {

late Future<List<Product>> _product;

var apiService=ApiService();





@override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: FutureBuilder(
            future:apiService.UserApi(),
            builder: (context,AsyncSnapshot<List<Users>> snapshot){

              if(snapshot.connectionState==ConnectionState.waiting){

                return Center(child: CircularProgressIndicator());

              }else if(snapshot.hasData){
               return snapshot.data!.isEmpty?const Center(child: Text("NO record found !!"),):ListView.builder(
                 itemCount: snapshot.data!.length,
                   itemBuilder: (context,index){

                     return Column(
                       children: [


                         Text(snapshot.data![index].id.toString()),
                         Text(snapshot.data![index].address.toString()),
                         Text(snapshot.data![index].password.toString()),
                         Text(snapshot.data![index].phone.toString()),
                         Text(snapshot.data![index].email.toString()),
                       ],
                     );
                   }
               );

              }else{

                return Center(
                  child: Text("No Found Pages"),
                );
              }
            },
          )
    );
  }
}
