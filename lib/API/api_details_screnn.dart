import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<dynamic> fetchPeople(http.Client client) async {
  final response =
  await client.get(Uri.parse('https://swapi.dev/api/people/?format=json'));

  var data = await json.decode(response.body);
  return data;
}

class ApiDetailsScreen extends StatefulWidget {
  const ApiDetailsScreen({Key? key}) : super(key: key);

  @override
  _ApiDetailsScreenState createState() => _ApiDetailsScreenState();
}

class _ApiDetailsScreenState extends State<ApiDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Details List'),
        centerTitle: true,
      ),
      body: FutureBuilder<dynamic>(
        future: fetchPeople(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PeopleList(people: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class PeopleList extends StatelessWidget {
  final dynamic people;

  const PeopleList({Key? key, required this.people}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var results = people['results'];

    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        var person = results[index];
        var name = person['name'];
        var eyeColor = person['eye_color'];
        var created = person['created'];
        var films = person['films'];
        var url = person['url'];

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  color: Colors.deepOrange,
                  width: 350, child: Text("Name : $name",
                style:const TextStyle(
                    fontSize: 18
                ),)),
              Container(
                width: 300,
                color: Colors.amberAccent,
                child: Text("Eye Color : $eyeColor",
                  style: const TextStyle(
                      fontSize: 18
                  ),),
              ),
              Container(
                width: 300,
                color: Colors.teal,
                child: Text("Created : $created",
                  style: const TextStyle(
                      fontSize: 18
                  ),),
              ),
              Container(
                width: 300,
                color: Colors.cyan,
                child: Text("Films :\n$films",
                  style: const TextStyle(
                      fontSize: 18
                  ),),
              ),
              Container(
                width: 300,
                color: Colors.amber,
                child: Text("URL : $url",
                  style: const TextStyle(
                      fontSize: 18
                  ),),
              ),
            ],
          ),
        );
      },
    );
  }
}
