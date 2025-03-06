import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride/ride_filter.dart';
import 'package:week_3_blabla_project/model/ride/ride_sort_type.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/model/user/user.dart';
import 'package:week_3_blabla_project/repository/mock/mock_location_repository.dart';
import 'package:week_3_blabla_project/repository/ride_repository.dart';
import 'package:week_3_blabla_project/utils/ride_utils.dart';

class MockRideRepository extends RideRepository {
  final List<Ride> _allRides = [];

  MockRideRepository() {
    User hout = User(firstName: "kok", lastName: "hout");
    User hong = User(firstName: "jin", lastName: "hong");

    final locationRepository = MockLocationRepository();

    Ride ride1 = Ride(
        departureLocation: locationRepository.btb,
        departureDate: DateTime.now().add(Duration(days: 1, hours: 8)),
        arrivalLocation: locationRepository.sr,
        arrivalDateTime: DateTime.now().add(Duration(days: 2, hours: 8)),
        driver: hout,
        availableSeats: 2,
        pricePerSeat: 10,
        allowPets: true);

    Ride ride2 = Ride(
        departureLocation: locationRepository.btb,
        departureDate: DateTime.now().add(Duration(days: 2, hours: 8)),
        arrivalLocation: locationRepository.sr,
        arrivalDateTime: DateTime.now().add(Duration(days: 2, hours: 8)),
        driver: hong,
        availableSeats: 0,
        pricePerSeat: 10);

    Ride ride3 = Ride(
        departureLocation: locationRepository.btb,
        departureDate: DateTime.now().add(Duration(days: 1, hours: 8)),
        arrivalLocation: locationRepository.sr,
        arrivalDateTime: DateTime.now().add(Duration(days: 2, hours: 8)),
        driver: hout,
        availableSeats: 1,
        pricePerSeat: 10,
        allowPets: true);

    Ride ride4 = Ride(
        departureLocation: locationRepository.btb,
        departureDate: DateTime.now().add(Duration(days: 1, hours: 8)),
        arrivalLocation: locationRepository.sr,
        arrivalDateTime: DateTime.now().add(Duration(days: 2, hours: 8)),
        driver: hong,
        availableSeats: 2,
        pricePerSeat: 10);

    Ride ride5 = Ride(
        departureLocation: locationRepository.btb,
        departureDate: DateTime.now().add(Duration(days: 1, hours: 8)),
        arrivalLocation: locationRepository.sr,
        arrivalDateTime: DateTime.now().add(Duration(days: 2, hours: 8)),
        driver: hout,
        availableSeats: 1,
        pricePerSeat: 10,
        allowPets: true);

    _allRides.addAll([ride1, ride2, ride3, ride4, ride5]);
  }

  @override
  List<Ride> getRide() {
    return _allRides;
  }

  @override
  List<Ride> getRidesFor(RidePreference pref, RideFilter? filter, RideSortType? sortType) {
    return filterAndSortRides(_allRides, pref, filter, sortType);
  }
  
}
