import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/repository/locations_repository.dart';

class MockLocationRepository extends LocationsRepository {
  final Location pp = Location(name: "PhnomPenh", country: Country.cambodia);
  final Location pv = Location(name: "PreyVeng", country: Country.cambodia);
  final Location kp = Location(name: "Kampot", country: Country.cambodia);
  final Location tk = Location(name: "Takeo", country: Country.cambodia);
  final Location sr = Location(name: "SiemReap", country: Country.cambodia);
  final Location btb = Location(name: "Battambong", country: Country.cambodia);

  @override
  List<Location> getLocations() {
    return [pp, pv, kp, tk, sr, btb];
  }
}
