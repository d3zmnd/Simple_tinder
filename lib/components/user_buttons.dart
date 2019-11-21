import 'package:flutter/material.dart';

class UserButtons extends StatelessWidget{
  const UserButtons({Key key, this.onReload, this.onNext}) : super(key: key);

  final Function onReload;
  final Function onNext;

  
    
    @override
    Widget build(BuildContext context){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Ink(
            decoration: ShapeDecoration(
              color: Colors.grey,
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Refresh user info',
              iconSize: 40,
              onPressed: () => onReload(),
            ),   
            
          ),
          Ink(
            decoration: ShapeDecoration(
              color: Colors.orange,
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: Icon(Icons.keyboard_arrow_up),
              tooltip: 'Open details page',
              iconSize: 40,
              onPressed: () => onNext(),
            ),
          ), 
        ]
      );
    }


}