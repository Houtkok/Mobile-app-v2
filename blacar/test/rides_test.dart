import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/mock/mock_ride_repository.dart';
import 'package:week_3_blabla_project/screens/rides/widgets/ride_filter.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';

void main() {
  // 1 - Create a ride services
  RidesService.initialize(MockRideRepository());

  // FAKE LOCATIONS
  final btb = Location(name: "Battambang", country: Country.cambodia);
  final sr = Location(name: "Siem Reap", country: Country.cambodia);
  final pp = Location(name: "Phnom Penh", country: Country.cambodia);
  final kp = Location(name: "Kampot", country: Country.cambodia);

  // 2 - Create ride preferences
  final ridePreference1 = RidePreference(
    departure: btb,
    departureDate: DateTime.now().add(const Duration(days: 1)),
    arrival: sr,
    requestedSeats: 1,
  );

  final ridePreference2 = RidePreference(
    departure: pp,
    departureDate: DateTime.now().add(const Duration(days: 2)),
    arrival: kp,
    requestedSeats: 2,
  );

  final ridePreference3 = RidePreference(
    departure: sr,
    departureDate: DateTime.now(),
    arrival: btb,
    requestedSeats: 1,
  );

  // 3 - Retrieve available rides
  final availableRides1 = RidesService.instance.getRidesFor(ridePreference1, null);
  final availableRides2 = RidesService.instance.getRidesFor(ridePreference2, null);
  final availableRides3 = RidesService.instance.getRidesFor(ridePreference3, null);

  // 4 - Print results
  print("Available Rides 1 (Battambang to Siem Reap):");
  _printRides(availableRides1);

  print("\nAvailable Rides 2 (Phnom Penh to Kampot):");
  _printRides(availableRides2);

  print("\nAvailable Rides 3 (Siem Reap to Battambang):");
  _printRides(availableRides3);

  // 5 - Example of filtering with pets
  final ridePreference4 = RidePreference(
    departure: btb,
    departureDate: DateTime.now().add(const Duration(days: 3)),
    arrival: sr,
    requestedSeats: 1,
  );

  final availableRides4 = RidesService.instance.getRidesFor(ridePreference4, RideFilter(onlyPets: true));
  print("\nAvailable Rides 4 (Battambang to Siem Reap, Pets Only):");
  _printRides(availableRides4);
}

void _printRides(List<Ride> rides) {
  if (rides.isEmpty) {
    print("  No rides available.");
  } else {
    for (final ride in rides) {
      print("  - ${ride.driver} - ${ride.departureLocation.name} to ${ride.arrivalLocation.name}, Seats: ${ride.availableSeats}, Pets: ${ride.allowPets}");
    }
  }
}