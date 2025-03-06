import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride/ride_filter.dart';
import 'package:week_3_blabla_project/model/ride/ride_sort_type.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/model/user/user.dart';
import 'package:week_3_blabla_project/repository/mock/mock_location_repository.dart';
import 'package:week_3_blabla_project/repository/ride_repository.dart';

class MockRideRepository extends RideRepository {
  final List<Ride> _allRides = [];

  MockRideRepository() {
    User hout = User(firstName: "kok", lastName: "hout");
    User hong = User(firstName: "jin", lastName: "hong");

    final locationRepository = MockLocationRepository();

    Ride ride1 = Ride(
        departureLocation: locationRepository.btb,
        departureDate: DateTime.now().copyWith(hour: 20, minute: 30),
        arrivalLocation: locationRepository.sr,
        arrivalDateTime: DateTime.now().copyWith(hour: 20, minute: 30),
        driver: hout,
        availableSeats: 2,
        pricePerSeat: 10,
        allowPets: true);

    Ride ride2 = Ride(
        departureLocation: locationRepository.btb,
        departureDate: DateTime.now().copyWith(hour: 20, minute: 30),
        arrivalLocation: locationRepository.sr,
        arrivalDateTime: DateTime.now().copyWith(hour: 20, minute: 30),
        driver: hong,
        availableSeats: 0,
        pricePerSeat: 10);

    Ride ride3 = Ride(
        departureLocation: locationRepository.btb,
        departureDate: DateTime.now().copyWith(hour: 20, minute: 30),
        arrivalLocation: locationRepository.sr,
        arrivalDateTime: DateTime.now().copyWith(hour: 20, minute: 30),
        driver: hout,
        availableSeats: 1,
        pricePerSeat: 10,
        allowPets: true);

    Ride ride4 = Ride(
        departureLocation: locationRepository.btb,
        departureDate: DateTime.now().copyWith(hour: 20, minute: 30),
        arrivalLocation: locationRepository.sr,
        arrivalDateTime: DateTime.now().copyWith(hour: 20, minute: 30),
        driver: hong,
        availableSeats: 2,
        pricePerSeat: 10);

    Ride ride5 = Ride(
        departureLocation: locationRepository.btb,
        departureDate: DateTime.now().copyWith(hour: 20, minute: 30),
        arrivalLocation: locationRepository.sr,
        arrivalDateTime: DateTime.now().copyWith(hour: 20, minute: 30),
        driver: hout,
        availableSeats: 1,
        pricePerSeat: 10,
        allowPets: true);

    _allRides.addAll([ride1, ride2, ride3, ride4, ride5]);
  }

  @override
  List<Ride> getRidesFor(RidePreference pref, RideFilter? filter, RideSortType? sortType) {
    List<Ride> rides = _allRides
        .where((ride) => _rideMatchesPreferences(ride, pref, filter))
        .toList();
        if (sortType != null) {
      switch (sortType) {
        case RideSortType.departureTime:
          rides.sort((a, b) => a.departureDate.compareTo(b.departureDate));
          break;
        case RideSortType.arrivalTime:
          rides.sort((a, b) => a.arrivalDateTime.compareTo(b.arrivalDateTime));
          break;
        case RideSortType.price:
          rides.sort((a, b) => a.pricePerSeat.compareTo(b.pricePerSeat));
          break;
      }
    }
    return rides;
  }

  bool _rideMatchesPreferences(
      Ride ride, RidePreference prefs, RideFilter? filter) {
    // departure and arraival mathc
    if (ride.departureLocation != prefs.departure ||
        ride.arrivalLocation != prefs.arrival) {
      return false;
    }

    //filter for pet
    if (filter != null && filter.onlyPets && !ride.allowPets) {
      return false;
    }

    //to ensure available seats
    if (ride.availableSeats <= 0) {
      return false;
    }

    return true;
  }
}
