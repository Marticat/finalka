import 'package:finalka/models/gym.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  LatLng? _currentPosition;
  final Set<Marker> _markers = {};
  String _currentAddress = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n!.pleaseEnableLocationServices)),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n!.locationPermissionsDenied)),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n!.locationPermissionsPermanentlyDenied)),
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });

      await _getAddressFromLatLng(_currentPosition!);
      _addGymMarkers();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${l10n!.errorGettingLocation}: ${e.toString()}')),
      );
    }
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _currentAddress = [
            place.street,
            place.locality,
            place.postalCode,
            place.country
          ].where((part) => part != null && part.isNotEmpty).join(', ');
        });
      }
    } catch (e) {
      final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${l10n!.errorGettingAddress}: ${e.toString()}')),
      );
    }
  }

  Future<void> _searchLocation() async {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations);
    if (_searchController.text.isEmpty) return;

    try {
      List<Location> locations = await locationFromAddress(_searchController.text);

      if (locations.isNotEmpty) {
        final location = locations.first;
        final newPosition = LatLng(location.latitude, location.longitude);

        setState(() {
          _currentPosition = newPosition;
        });

        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(newPosition, 15),
        );

        await _getAddressFromLatLng(newPosition);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${l10n!.noResultsFoundFor} "${_searchController.text}"')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${l10n!.errorSearchingLocation}: ${e.toString()}')),
      );
    }
  }

  void _addGymMarkers() {
    for (var gym in gyms) {
      _markers.add(
        Marker(
          markerId: MarkerId(gym.id),
          position: LatLng(gym.latitude, gym.longitude),
          infoWindow: InfoWindow(
            title: gym.name,
            snippet: gym.address,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = Localizations.of<AppLocalizations>(context, AppLocalizations);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.findGymsNearby),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _getCurrentLocation,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n.searchLocation,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchLocation,
                ),
              ),
              onSubmitted: (value) => _searchLocation(),
            ),
          ),
          if (_currentAddress.isNotEmpty)
            ListTile(
              leading: const Icon(Icons.location_pin),
              title: Text(l10n.yourLocation),
              subtitle: Text(_currentAddress),
              trailing: IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _currentAddress));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.addressCopied)),
                  );
                },
              ),
            ),
          Expanded(
            child: _currentPosition == null
                ? const Center(child: CircularProgressIndicator())
                : GoogleMap(
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
              initialCameraPosition: CameraPosition(
                target: _currentPosition!,
                zoom: 15,
              ),
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'zoomIn',
            onPressed: () {
              mapController.animateCamera(CameraUpdate.zoomIn());
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'zoomOut',
            onPressed: () {
              mapController.animateCamera(CameraUpdate.zoomOut());
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}