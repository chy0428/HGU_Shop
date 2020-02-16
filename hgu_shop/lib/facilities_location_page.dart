import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'
    show AppBar, BuildContext, Colors, Container, EdgeInsets, FontWeight, MediaQuery, Scaffold, Stack, State, StatefulWidget, StreamBuilder, Text, TextStyle, Widget;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// 이건 편의시설 지도!!!
class Facil_Store_LocationPage extends StatefulWidget {
  final int idx;
  final double latitude;
  final double longitud;

  const Facil_Store_LocationPage({Key key, this.idx, this.latitude, this.longitud}) : super(key: key);

  @override
  _Facil_Store_LocationPageState createState() => _Facil_Store_LocationPageState(idx, latitude, longitud);
}

class _Facil_Store_LocationPageState extends State<Facil_Store_LocationPage> {
  List<Marker> allMarkers=[];
  final int idx;
  final double latitude;
  final double longitud;

  _Facil_Store_LocationPageState(this.idx, this.latitude, this.longitud);


  @override
  void initState(){
    super.initState();
    allMarkers.add(Marker(markerId: MarkerId(' '),

        draggable: false, // marker 드래그 불가능 상태

        onTap: (){
          print('Marker Tapped');
        },
        position: LatLng(latitude, longitud)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
            stream: Firestore.instance.collection('편의 시설').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text('Loading data...');
              return

                Container(
                    margin: EdgeInsets.all(16),
                    child: Text(
                      snapshot.data.documents[idx]['name'], style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),));
            }
        ),
      ),

      body: Stack(
          children: [Container( // 기준이되는 Marker
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:
            GoogleMap(initialCameraPosition: CameraPosition(
                target: LatLng(latitude, longitud), // 한동대 위도 경도
                zoom: 15.0
            ),
              markers: Set.from(allMarkers), // marker
              // onMapCreated: mapCreated,
            ),
          ),
          ]
      ),
    );
  }
}