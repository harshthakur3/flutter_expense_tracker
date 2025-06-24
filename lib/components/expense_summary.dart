import 'package:expence_tracker/bar_graph/bar_graph.dart';
import 'package:expence_tracker/data/expense_data.dart';
import 'package:expence_tracker/datetine/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });

  @override
  Widget build(BuildContext context) {
    // get yyyymmdd for each day of this week
    String sunday = convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday = convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday = convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday = convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday = convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) {
        final sun = value.calculateDailyExpenseSummary()[sunday] ?? 0;
        final mon = value.calculateDailyExpenseSummary()[monday] ?? 0;
        final tue = value.calculateDailyExpenseSummary()[tuesday] ?? 0;
        final wed = value.calculateDailyExpenseSummary()[wednesday] ?? 0;
        final thur = value.calculateDailyExpenseSummary()[thursday] ?? 0;
        final fri = value.calculateDailyExpenseSummary()[friday] ?? 0;
        final sat = value.calculateDailyExpenseSummary()[saturday] ?? 0;

        // Calculate maxY dynamically
        double maxY = [sun, mon, tue, wed, thur, fri, sat].reduce((a, b) => a > b ? a : b);

        // Optionally fallback to 100 if all values are 0
        if (maxY == 0) maxY = 100;

        return SizedBox(
          height: 200,
          child: MyBarGraph(
            maxY: maxY,
            sunAmount: sun,
            monAmount: mon,
            tueAmount: tue,
            wedAmount: wed,
            thurAmount: thur,
            friAmount: fri,
            satAmount: sat,
          ),
        );
      },
    );
  }
}
