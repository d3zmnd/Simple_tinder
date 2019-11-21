import 'package:tinder_app/components/pages/details_page_landscape.dart';
import 'package:tinder_app/components/pages/details_page_portrait.dart';
import 'package:tinder_app/models/user_model.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget{
  const DetailsPage({Key key, this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name)
      ),
      body: Center(
        child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation){
            return orientation == Orientation.portrait 
              ?
                DetailsPagePortrait(user: user)
              : 
                DetailsPageLandscape(user: user);
          }       
        ),
      )
    );
  }
}