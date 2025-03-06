import 'package:flutter_test/flutter_test.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride/ride_sort_type.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/mock/mock_ride_repository.dart';
import 'package:week_3_blabla_project/model/ride/ride_filter.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';

void main() {
  group('RidesService Tests', () {
    setUp(() {
      RidesService.initialize(MockRideRepository());
    });

    final btb = Location(name: "Battambang", country: Country.cambodia);
    final sr = Location(name: "Siem Reap", country: Country.cambodia);
    final pp = Location(name: "Phnom Penh", country: Country.cambodia);
    final kp = Location(name: "Kampot", country: Country.cambodia);

    test('Test available rides 1', () {
      final ridePreference1 = RidePreference(
        departure: btb,
        departureDate: DateTime.now(),
        arrival: sr,
        requestedSeats: 1,
      );

      final availableRides1 = RidesService.instance.getRidesFor(ridePreference1, null, RideSortType.departureTime);
      expect(availableRides1.length, 0);
      print("Available Rides 1 (Battambang to Siem Reap):");
      _printRides(availableRides1,ridePreference1);
    });

    test('Test available rides 2', () {
      final ridePreference2 = RidePreference(
        departure: pp,
        departureDate: DateTime.now().add(const Duration(days: 2)),
        arrival: kp,
        requestedSeats: 2,
      );

      final availableRides2 = RidesService.instance.getRidesFor(ridePreference2, null, RideSortType.arrivalTime);
      expect(availableRides2.length, 0);
      print("\nAvailable Rides 2 (Phnom Penh to Kampot):");
      _printRides(availableRides2,ridePreference2);
    });

    test('Test available rides 3', () {
      final ridePreference3 = RidePreference(
        departure: sr,
        departureDate: DateTime.now(),
        arrival: btb,
        requestedSeats: 1,
      );

      final availableRides3 = RidesService.instance.getRidesFor(ridePreference3, null, RideSortType.price);
      expect(availableRides3.length, 0);
      print("\nAvailable Rides 3 (Siem Reap to Battambang):");
      _printRides(availableRides3,ridePreference3);
    });

    test('Test available rides 4 (pets only)', () {
      final ridePreference4 = RidePreference(
        departure: btb,
        departureDate: DateTime.now().add(const Duration(days: 3)),
        arrival: sr,
        requestedSeats: 1,
      );

      final availableRides4 = RidesService.instance.getRidesFor(ridePreference4, RideFilter(onlyPets: true), RideSortType.departureTime);
      expect(availableRides4.length, 0);
      print("\nAvailable Rides 4 (Battambang to Siem Reap, Pets Only):");
      _printRides(availableRides4,ridePreference4);
    });

    test('Test available rides with seats', () {
      final ridePreference5 = RidePreference(
        departure: btb,
        departureDate: DateTime.now(),
        arrival: sr,
        requestedSeats: 1,
      );

      final availableRides5 = RidesService.instance.getRidesFor(ridePreference5, null, RideSortType.departureTime);
      expect(availableRides5.length, 0); 
      print("\nAvailable Rides with Seats (Battambang to Siem Reap):");
      _printRides(availableRides5,ridePreference5);
    });
  });
}

void _printRides(List<Ride> rides, RidePreference preference) {
  if (rides.isEmpty) {
    print("  No rides available for ${preference.departure.name} -> ${preference.arrival.name}.");
  } else {
    print("For your preference (${preference.departure.name} -> ${preference.arrival.name}, today ${preference.requestedSeats} passenger) we found ${rides.length} rides:");
    for (final ride in rides) {
      final departureTime = "${ride.departureDate.hour.toString().padLeft(2, '0')}.${ride.departureDate.minute.toString().padLeft(2, '0')} am";
      final duration = ride.arrivalDateTime.difference(ride.departureDate);
      final durationHours = duration.inHours;

      print("  - at $departureTime with ${ride.driver.firstName} (${durationHours} hours)");
    }
  }
}