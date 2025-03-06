import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride_filter.dart';
import 'package:week_3_blabla_project/model/ride/ride_sort_type.dart';

class FilterSortDialog extends StatefulWidget {
  final RideFilter currentFilter;
  final RideSortType? currentSortType;
  final ValueChanged<RideFilter> onFilterChanged;
  final ValueChanged<RideSortType?> onSortTypeChanged;

  const FilterSortDialog({
    super.key,
    required this.currentFilter,
    required this.currentSortType,
    required this.onFilterChanged,
    required this.onSortTypeChanged,
  });

  @override
  State<FilterSortDialog> createState() => _FilterSortDialogState();
}

class _FilterSortDialogState extends State<FilterSortDialog> {
  late RideFilter _filter;
  RideSortType? _sortType;

  @override
  void initState() {
    super.initState();
    _filter = widget.currentFilter;
    _sortType = widget.currentSortType;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Filter and Sort'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Filter options
          CheckboxListTile(
            title: Text('Only Pets'),
            value: _filter.onlyPets,
            onChanged: (bool? value) {
              setState(() {
                _filter = _filter.copyWith(onlyPets: value ?? false);
              });
            },
          ),
          // Sort options
          DropdownButton<RideSortType>(
            value: _sortType,
            hint: Text('Sort by'),
            onChanged: (RideSortType? newValue) {
              setState(() {
                _sortType = newValue;
              });
            },
            items: RideSortType.values.map((RideSortType sortType) {
              return DropdownMenuItem<RideSortType>(
                value: sortType,
                child: Text(sortType.toString().split('.').last),
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onFilterChanged(_filter);
            widget.onSortTypeChanged(_sortType);
            Navigator.of(context).pop();
          },
          child: Text('Apply'),
        ),
      ],
    );
  }
}