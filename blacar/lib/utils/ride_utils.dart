import '../model/ride/ride.dart';
import '../model/ride/ride_filter.dart';
import '../model/ride/ride_sort_type.dart';
import '../model/ride_pref/ride_pref.dart';

List<Ride> filterAndSortRides(List<Ride> rides, RidePreference pref, RideFilter? filter, RideSortType? sortType) {
  List<Ride> filteredRides = rides.where((ride) {
    bool matches = ride.departureLocation == pref.departure &&
                   ride.arrivalLocation == pref.arrival &&
                   ride.departureDate.isAfter(pref.departureDate) &&
                   ride.availableSeats >= pref.requestedSeats;

    if (filter != null && filter.onlyPets) {
      matches = matches && ride.allowPets;
    }

    return matches;
  }).toList();

  if (sortType != null) {
    switch (sortType) {
      case RideSortType.departureTime:
        filteredRides.sort((a, b) => a.departureDate.compareTo(b.departureDate));
        break;
      case RideSortType.arrivalTime:
        filteredRides.sort((a, b) => a.arrivalDateTime.compareTo(b.arrivalDateTime));
        break;
      case RideSortType.price:
        filteredRides.sort((a, b) => a.pricePerSeat.compareTo(b.pricePerSeat));
        break;
    }
  }

  return filteredRides;
}