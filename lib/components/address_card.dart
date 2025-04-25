import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class AddressCard extends StatelessWidget {
  final double? latitude;
  final double? longitude;
  final String? address;

  const AddressCard({
    super.key,
    this.latitude,
    this.longitude,
    this.address,
  });

  Future<String> _getFullAddress(double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isEmpty) return 'Unknown location';

      final place = placemarks.first;
      return [
        if (place.street != null) place.street,
        if (place.locality != null) place.locality,
        if (place.postalCode != null) place.postalCode,
        if (place.country != null) place.country,
      ].where((part) => part != null && part.isNotEmpty).join(', ');
    } catch (e) {
      return 'Could not get address';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: address != null
          ? Future.value(address)
          : (latitude != null && longitude != null)
          ? _getFullAddress(latitude!, longitude!)
          : Future.value('No location data'),
      builder: (context, snapshot) {
        final addressText = snapshot.data ?? 'Loading address...';
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    addressText,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    if (addressText.isNotEmpty) {
                      Clipboard.setData(ClipboardData(text: addressText));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Address copied')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}