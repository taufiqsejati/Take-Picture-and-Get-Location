import 'package:flutter/material.dart';
import 'package:flutter_take_picture/location_service.dart';
import 'user_location.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  LocationService locationService = LocationService();

  @override
  void dispose() {
    locationService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Location'),
      ),
      body: StreamBuilder<UserLocation>(
        stream: locationService.locationStream,
        builder: (_, snapshot) => (snapshot.hasData)
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Latitude'),
                    Text(
                      '${snapshot.data.latitude}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('Longitude: '),
                    Text(
                      '${snapshot.data.longitude}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
