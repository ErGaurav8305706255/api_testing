import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomModel extends StatefulWidget {
  const CustomModel({Key? key}) : super(key: key);

  @override
  State<CustomModel> createState() => _CustomModelState();
}

class _CustomModelState extends State<CustomModel> {


  List<Photo> photosList = [];
  Future<List<Photo>> getphoto ()async{
    final response  =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      photosList.clear();
      for (Map i in data){
        Photo photo = Photo(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photo);
      }
      return photosList;
    }else{
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Custom Model'),centerTitle: true,
       ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getphoto(),
                  builder: (context, AsyncSnapshot<List<Photo>> snapshot) {
                if(!snapshot.hasData){
                  return Center(child: Text('Loading...'));
                }else{
                  return ListView.builder(
                      itemCount: photosList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                          ),
                          title: Text('Notes ID =>'+snapshot.data![index].id.toString()),
                          subtitle: Text(snapshot.data![index].title.toString()),
                        );
                      });
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
class Photo{
  String title, url;
  int id;
  Photo({required this.title, required this.url, required this.id});
}
