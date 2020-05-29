import 'dart:convert';
import 'package:http/http.dart';

class Network{
  final String url;
  Network(this.url);
  Future getData() async{
    Response response=await get(url);


    if(response.statusCode==200){
      var decode=jsonDecode(response.body);
      return decode;
    }
    else{
      print(response.statusCode);
    }
  }


}
