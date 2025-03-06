import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride_filter.dart';
import 'package:week_3_blabla_project/model/ride/ride_sort_type.dart';
import 'package:week_3_blabla_project/screens/rides/widgets/filter_sort_dialog.dart';
import 'package:week_3_blabla_project/screens/rides/widgets/ride_pref_modal.dart';
import 'package:week_3_blabla_project/service/ride_prefs_service.dart';
import 'widgets/ride_pref_bar.dart';

import '../../dummy_data/dummy_data.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/rides_service.dart';
import '../../theme/theme.dart';

import 'widgets/rides_tile.dart';

///
///  The Ride Selection screen allow user to select a ride, once ride preferences have been defined.
///  The screen also allow user to re-define the ride preferences and to activate some filters.
///
class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  RidePreference get currentPreference => RidePrefService.instance.currentPreference!; // TODO 1 :  We should get it from the service

  RideFilter curFilter = RideFilter();
  RideSortType? sortType;
  List get matchRides =>
      RidesService.instance.getRidesFor(currentPreference, curFilter, sortType);

  void onBackPressed() {
    Navigator.of(context).pop(); //  Back to the previous view
  }

  void onPreferencePressed() async {
    // TODO  6 : we should push the modal with the current pref
    final newPref = await Navigator.of(context).push<RidePreference>(
      MaterialPageRoute(
          builder: (context) => RidePrefModal(initPref: currentPreference)),
    );
    // TODO 9 :  After pop, we should get the new current pref from the modal
    if (newPref != null) {
      // TODO 10 :  Then we should update the service current pref,   and update the view
      setState(() {
        RidePrefService.instance.setCurrentPreference(newPref);
      });
    }
  }

  void onFilterPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterSortDialog(
          currentFilter: curFilter,
          currentSortType: sortType,
          onFilterChanged: (newFilter) {
            applyFilterAndSort(newFilter, sortType);
          },
          onSortTypeChanged: (newSortType) {
            applyFilterAndSort(curFilter, newSortType);
          },
        );
      },
    );
  }

  void applyFilterAndSort(RideFilter newFilter, RideSortType? newSortType){
    setState(() {
      curFilter = newFilter;
      sortType = newSortType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(
          left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
      child: Column(
        children: [
          // Top search Search bar
          RidePrefBar(
              ridePreference: currentPreference,
              onBackPressed: onBackPressed,
              onPreferencePressed: onPreferencePressed,
              onFilterPressed: onFilterPressed,
              ),
          Expanded(
            child: ListView.builder(
              itemCount: matchRides.length,
              itemBuilder: (ctx, index) => RideTile(
                ride: matchRides[index],
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
