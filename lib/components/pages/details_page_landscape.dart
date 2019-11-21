import 'package:tinder_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';

class DetailsPageLandscape extends StatelessWidget{
  const DetailsPageLandscape({Key key, this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context){
    return  Row(
      children: <Widget>[
        Expanded(
          flex:4,
          child: Hero(
            tag: 'avatar',
            child: GestureDetector(                
              onTap: () => Navigator.pop(context),
              child: Image.network(
                user.image,
                fit:BoxFit.fill,
              ),
            )
          ), 
        ),
        Expanded(
          flex: 5,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: FutureBuilder<LatLng>(
                  future: _getCoordinates(),
                  builder: (BuildContext context, AsyncSnapshot<LatLng> snapshot){
                    if(snapshot.hasData){
                      final num km = Distance().as(LengthUnit.Kilometer, snapshot.data, LatLng(user.latitude,user.longitude));
                      return Text(
                        '${user.name} is $km km away from you!',
                        style: Theme.of(context).textTheme.subtitle,
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        'Please turn on the geolocation',
                        style: Theme.of(context).textTheme.headline,                    
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }
                )
              ),
            ), 
          ],
        ) 
      )
        
      ],
    ); 
  }       
  
  Future<LatLng> _getCoordinates() async{
    final LocationPermissions permission = LocationPermissions();
    await permission.requestPermissions();

    final Geolocator geolocator = Geolocator();
    final Position position = await geolocator.getLastKnownPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }
}