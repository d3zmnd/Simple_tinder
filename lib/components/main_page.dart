import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:tinder_app/components/pages/details_page.dart';
import 'package:tinder_app/components/user_buttons.dart';
import 'package:tinder_app/models/user_model.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<User> _user;

  @override
  void initState() {
    super.initState();
    _user = _generateUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('T1nder app'),
      ),
      body: Center(
        child: FutureBuilder<User>(
          future: _user,
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if(snapshot.hasData){
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Hero(
                      tag: 'avatar',
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push<void>(
                            MaterialPageRoute<dynamic>(
                              builder:(BuildContext context)=> 
                                DetailsPage(user: snapshot.data)
                            ),
                          );
                        },
                        onHorizontalDragStart: (DragStartDetails context)=> setState((){
                          _user = _generateUser();
                        }),
                        child: Image.network(
                          snapshot.data.image,
                          fit:BoxFit.fill,
                          height: 300,
                          width: 300,
                        ),
                      )
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        snapshot.data.name,  
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ),
                    UserButtons(
                      onReload: () => 
                        setState((){
                          _user = _generateUser();
                      }),
                      onNext: () {
                        Navigator.of(context).push<void>(
                        MaterialPageRoute<dynamic>(
                          builder:(BuildContext context)=> 
                            DetailsPage(user: snapshot.data)
                          ),
                        );
                      },
                    ),
                  ],
                ), 
              );
            } else if (snapshot.hasError) {
                return const Text(
                    'Something is wrong. Check your internet connection');
            } else {
              return const CircularProgressIndicator();
            }
          }
        )    
      )
    );
  }
  
  Future<User> _generateUser() async{
    final Uri uri = Uri.https('randomuser.me', '/api/1.3');
    final http.Response response = await http.get(uri);
    return compute(_parseUser, response.body);
  }
  static User _parseUser(String response){
    final Map<String, dynamic> parsed = json.decode(response);
    return User.fromRandomUserResponse(parsed);
  }
}
