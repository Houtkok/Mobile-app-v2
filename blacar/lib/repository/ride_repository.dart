import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/screens/rides/widgets/ride_filter.dart';

abstract class RideRepository {
  RideFilter curFilter = RideFilter();

  List<Ride> getRidesFor (RidePreference preference,RideFilter? filter);
}