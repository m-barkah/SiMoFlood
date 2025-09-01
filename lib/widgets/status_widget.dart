import 'package:flutter/material.dart';
import '../services/notifications.dart';

class StatusWidget extends StatelessWidget {
  final String status;

  const StatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;

    switch (status.toLowerCase()) {
      case 'aman':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'waspada':
        statusColor = Colors.orange;
        statusIcon = Icons.warning_amber;
        break;
      case 'bahaya':
        statusColor = Colors.red;
        statusIcon = Icons.dangerous;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          NotificationService().showAlarmNotification();
        });
        break;
      default:
        statusColor = Colors.blue;
        statusIcon = Icons.check_circle;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(statusIcon, color: statusColor, size: 40),
          const SizedBox(width: 16),
          Text(
            status,
            style: TextStyle(
              fontSize: 20,
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
