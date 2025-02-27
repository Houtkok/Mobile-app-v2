import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/service/locations_service.dart';

class LocationPickerWidget extends StatefulWidget {
  final Location? initialLocation;

  const LocationPickerWidget({super.key, this.initialLocation});

  @override
  State<LocationPickerWidget> createState() => _LocationPickerWidgetState();
}

class _LocationPickerWidgetState extends State<LocationPickerWidget> {
  String _searchText = '';
  List<Location> _filteredLocations = LocationsService.availableLocations;

  @override
  void initState() {
    super.initState();
    if (widget.initialLocation != null) {
      _searchText = widget.initialLocation!.name;// set initail search
      _filteredLocations = LocationsService.availableLocations;//reset filter
    }
  }

  void _filterLocations(String searchText) {
    setState(() {
      _searchText = searchText; //update search
      _filteredLocations = searchText.isEmpty
          ? LocationsService.availableLocations
          : LocationsService.availableLocations
              .where((location) => location.name
                  .toLowerCase()
                  .contains(searchText.toLowerCase())) // filter by nmame
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search location',
            border: InputBorder.none,
          ),
          onChanged: _filterLocations,
          controller: TextEditingController(text: _searchText),
        ),
        actions: [
          IconButton( //clear input
            icon: const Icon(Icons.clear),
            onPressed: () => _filterLocations(''),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _filteredLocations.length,
        itemBuilder: (context, index) {
          final location = _filteredLocations[index];
          return ListTile(
            title: Text(location.name),
            subtitle: Text(location.country.name),
            onTap: () => Navigator.pop(context, location),
            trailing: const Icon(Icons.arrow_forward_ios),
          );
        },
      ),
    );
  }
}
