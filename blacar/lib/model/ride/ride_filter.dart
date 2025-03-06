class RideFilter {
  final bool onlyPets;

  const RideFilter({this.onlyPets = false});

  RideFilter copyWith({bool? onlyPets}) {
    return RideFilter(
      onlyPets: onlyPets ?? this.onlyPets,
    );
  }
}