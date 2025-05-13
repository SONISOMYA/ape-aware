// ignore_for_file: file_names

import 'package:apeaware/models/monkey_log.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AlertsLogScreen extends StatelessWidget {
  const AlertsLogScreen({super.key});

  // Fetch logs from Firestore
  Future<List<MonkeyLog>> fetchLogs() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('monkey_alerts')
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => MonkeyLog.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>,
              SnapshotOptions() as SnapshotOptions?, 
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monkey Alerts Log')),
      body: FutureBuilder<List<MonkeyLog>>(
        future: fetchLogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No logs found."));
          }

          final logs = snapshot.data!;
          return ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              return ListTile(
                leading: const Icon(Icons.warning, color: Colors.red),
                title: Text(
                    "Confidence: ${(log.confidence * 100).toStringAsFixed(2)}%"),
                subtitle: Text("Time: ${log.timestamp}"),
              );
            },
          );
        },
      ),
    );
  }
}
