import 'package:apeaware/models/monkey_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  void _makeCall() {
    if (kDebugMode) {
      print("Call initiated to Forest Department.");
    }
  }

  // Define the Firestore reference to your collection where monkey logs are stored
  final Query<MonkeyLog> alertsRef = FirebaseFirestore.instance
      .collection('monkey_alerts')
      .orderBy('timestamp', descending: true)
      .withConverter<MonkeyLog>(
        fromFirestore: MonkeyLog.fromFirestore,
        toFirestore: (MonkeyLog log, SetOptions? options) =>
            log.toFirestore(options),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Dashboard"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recent Alerts",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: StreamBuilder<QuerySnapshot<MonkeyLog>>(
                  stream: alertsRef.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text("No alerts yet.",
                              style: TextStyle(color: Colors.white)));
                    }

                    final logs = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: logs.length,
                      itemBuilder: (context, index) {
                        final log = logs[index].data();

                        return Card(
                          color: Colors.deepPurple.shade100,
                          child: ListTile(
                            leading:
                                const Icon(Icons.warning, color: Colors.red),
                            title: Text(
                              "Monkey Detected",
                              style: const TextStyle(color: Colors.black),
                            ),
                            subtitle: Text(
                              "Time: ${(log.timestamp).toDate().toString().split('.')[0]}",
                              style: const TextStyle(color: Colors.black87),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton.icon(
                  onPressed: _makeCall,
                  icon: const Icon(Icons.call),
                  label: const Text("Call Nearest Guard"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
