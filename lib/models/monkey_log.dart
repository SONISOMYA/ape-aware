import 'package:cloud_firestore/cloud_firestore.dart';

class MonkeyLog {
  final double confidence;
  final int classId;
  final dynamic timestamp; // Keep dynamic to avoid type issues

  MonkeyLog({
    required this.confidence,
    required this.classId,
    required this.timestamp,
  });

  factory MonkeyLog.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = doc.data()!;
    return MonkeyLog(
      confidence: (data['confidence'] ?? 0.0).toDouble(),
      classId: (data['class_id'] ?? 0),
      timestamp: data['timestamp'], // Don't parse it here
    );
  }

  Map<String, dynamic> toFirestore(SetOptions? options) {
    return {
      'confidence': confidence,
      'class_id': classId,
      'timestamp': timestamp,
    };
  }
}
