import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackutd9/services/deal.dart';

class Nearby extends StatefulWidget {
  const Nearby({super.key});

  @override
  State<Nearby> createState() => _NearbyState();
}

class _NearbyState extends State<Nearby> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(32.9857, -96.7502);
  // final int _radius = 20;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    Deal.getDeals(
            // centerLoc: GeoPoint(_center.latitude, _center.longitude),
            // radius: _radius,
            )
        .then((deals) {
      setState(() {
        _markers = Set.from(
          deals.map((deal) {
            return Marker(
              markerId: MarkerId(deal.id),
              position: LatLng(deal.location.latitude, deal.location.longitude),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        content: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Column(
                            children: [
                              Text(deal.item),
                              Text('Original Price: \$${deal.price}'),
                              Text('Discount: ${deal.discount}'),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: const Text('Exit'),
                            onPressed: () => Navigator.of(context).pop(),
                          )
                        ],
                      );
                    });
              },
            );
          }),
        );
      });
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Nearby Deals'),
      //   centerTitle: true,
      //   titleTextStyle: TextStyle(fontSize: 25, fontFamily: 'BreeSerif'),
      //   backgroundColor: Colors.blue[600],
      // ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _markers,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.black,
          onPressed: () => mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
          ),
          child: const Icon(Icons.center_focus_strong, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
    );
  }
}
