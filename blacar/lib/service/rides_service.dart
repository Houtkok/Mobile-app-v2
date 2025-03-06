import 'package:week_3_blabla_project/model/ride/ride_sort_type.dart';
import 'package:week_3_blabla_project/repository/ride_repository.dart';
import 'package:week_3_blabla_project/model/ride/ride_filter.dart';
import 'package:week_3_blabla_project/utils/ride_utils.dart';

import '../model/ride_pref/ride_pref.dart';

import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {

  static RidesService? _instance;

  final RideRepository repository;

  // private constructor
  RidesService._internal(this.repository);

  /// Initialize
  static void initialize(RideRepository repository) {
     _instance ??= RidesService._internal(repository);
  }

  /// Singleton accessor
  static RidesService get instance {
    return _instance ?? (throw Exception("Rides service is not yet initialized."));
  }

  ///
  ///  Return the relevant rides, given the passenger preferences
  ///
  List<Ride> getRidesFor(RidePreference preferences, RideFilter? filter, RideSortType? sortType) {
    List<Ride> rides = repository.getRide();
    return filterAndSortRides(rides, preferences, filter, sortType);
  }
 
}