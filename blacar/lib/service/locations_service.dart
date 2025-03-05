import 'package:week_3_blabla_project/repository/locations_repository.dart';
import '../model/ride/locations.dart';

////
///   This service handles:
///   - The list of available rides
///
class LocationsService {
  static LocationsService? _instance;

  final LocationsRepository repository;

  LocationsService._internal(this.repository);

  // initialize
  static void initialize(LocationsRepository repository) {
    if (_instance == null) {
      _instance = LocationsService._internal(repository);
    } else {
      throw Exception("Location Service already initial.");
    }
  }

  // access with singleton
  static LocationsService get instance {
    if (_instance == null) {
      throw Exception("Location service not yet initial.");
    }
    return _instance!;
  }

  List<Location> getLocations() {
    return repository.getLocations();
  }

  List<Location> getLocationsFor(String searchText) {
    if (searchText.isEmpty) {
      return repository.getLocations(); // return all if search is empty
    }

    final lowerSearchText = searchText.toLowerCase();
    return repository
        .getLocations()
        .where(
            (location) => location.name.toLowerCase().contains(lowerSearchText))
        .toList();
  }
}
