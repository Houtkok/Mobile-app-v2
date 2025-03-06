import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride/ride_sort_type.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/model/ride/ride_filter.dart';

abstract class RideRepository {
  List<Ride> getRide();
  List<Ride> getRidesFor (RidePreference preference,RideFilter? filter, RideSortType? sortType);
}