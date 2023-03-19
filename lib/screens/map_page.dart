import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lab3_mis_196023/location_controller.dart';
import 'package:lab3_mis_196023/location_search_dialogue.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  bool searchToggle = false;
  bool getDirections = false;

  @override
  void initState() {
    super.initState();
    _cameraPosition = CameraPosition(
      target: LatLng(41.99646, 21.43141),
      zoom: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Google Maps'),
          ),
          body: Stack(
            children: <Widget>[
              GoogleMap(
                  onMapCreated: (GoogleMapController mapController) {
                    _mapController = mapController;
                  },
                  initialCameraPosition: _cameraPosition),
              Positioned(
                top: 100,
                left: 10,
                right: 20,
                child: GestureDetector(
                  onTap: () => Get.dialog(
                    LocationSearchDialog(mapController: _mapController),
                  ),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, size: 25),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            '${locationController.pickPlaceMark.name ?? ''} '
                            '${locationController.pickPlaceMark.locality ?? ''} '
                            '${locationController.pickPlaceMark.postalCode ?? ''} '
                            '${locationController.pickPlaceMark.country ?? ''} ',
                            style: TextStyle(fontSize: 20),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.search,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}
