import 'dart:convert';

import 'package:api_testing/Models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiScreen extends StatefulWidget {
  const ApiScreen({Key? key}) : super(key: key);

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {

  List<PostModel> postlist = [];
  Future<List<PostModel>> getpostApi ()async{
    final response  =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      postlist.clear();
      for (Map i in data){
        postlist.add(PostModel.fromJson(i));
      }
      return postlist;
    }else{
      return postlist;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Testing'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getpostApi(),
                  builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Center(child: Text('Loading...'));
                  }else{
                    return ListView.builder(
                        itemCount: postlist.length,
                        itemBuilder:  (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('User id =>',style: TextStyle(
                                    fontWeight: FontWeight.bold),),
                                      Text(postlist[index].userId.toString()),
                                  SizedBox(height: 10),
                                  Text('ID =>',style: TextStyle(
                                     fontWeight: FontWeight.bold
                                  )),
                                  Text(postlist[index].id.toString()),
                                  SizedBox(height: 10),
                                  Text('Title =>',style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  )),
                                  Text(postlist[index].title.toString()),
                                  SizedBox(height: 10),
                                  Text('Description =>',style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  )),
                                  Text(postlist[index].body.toString())


                                ],
                              ),
                            ),
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
