import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gemma/services/auth.dart';
import 'package:gemma/views/educators.dart';
import 'package:gemma/views/welcome.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  AuthService authService = new AuthService();
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.646866, 46.6923483),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Google Map'
        ),
        actions: [
          GestureDetector(
            onTap: () {
              //authService.signOut();
              //Navigator.pushReplacement(
              //  context, MaterialPageRoute(builder: (context) => SignIn()));
              //Navigator.pushReplacement(context,
              //MaterialPageRoute(builder: (context) => Authenticate()));
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Educator()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller){
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
            },
          ),
        ],
      ),
    );
  }
}





