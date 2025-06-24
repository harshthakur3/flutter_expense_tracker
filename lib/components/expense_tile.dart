import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  final void Function(BuildContext)? onPressed;

  const ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: onPressed,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
        ],
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text(
          '${dateTime.day} / ${dateTime.month} / ${dateTime.year}',
        ),
        trailing: Text('₹$amount'),
      ),
    );
  }
}
