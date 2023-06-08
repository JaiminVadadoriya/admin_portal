// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  Timestamp firstRoundEnd;
  Timestamp firstRoundStart;
  Timestamp mockRoundEnd;
  Timestamp mockRoundStart;

  Admin({
    required this.firstRoundEnd,
    required this.firstRoundStart,
    required this.mockRoundEnd,
    required this.mockRoundStart,
  });

  Admin copyWith({
    Timestamp? firstRoundEnd,
    Timestamp? firstRoundStart,
    Timestamp? mockRoundEnd,
    Timestamp? mockRoundStart,
  }) {
    return Admin(
      firstRoundEnd: firstRoundEnd ?? this.firstRoundEnd,
      firstRoundStart: firstRoundStart ?? this.firstRoundStart,
      mockRoundEnd: mockRoundEnd ?? this.mockRoundEnd,
      mockRoundStart: mockRoundStart ?? this.mockRoundStart,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstRoundEnd': firstRoundEnd,
      'firstRoundStart': firstRoundStart,
      'mockRoundEnd': mockRoundEnd,
      'mockRoundStart': mockRoundStart,
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (firstRoundEnd != null) 'firstRoundEnd': firstRoundEnd,
      if (firstRoundStart != null) 'firstRoundStart': firstRoundStart,
      if (mockRoundEnd != null) 'mockRoundEnd': mockRoundEnd,
      if (mockRoundStart != null) 'mockRoundStart': mockRoundStart,
    };
  }

  factory Admin.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Admin(
      firstRoundEnd: data?['firstRoundEnd'] as Timestamp,
      firstRoundStart: data?['firstRoundStart'] as Timestamp,
      mockRoundStart: data?['mockRoundStart'] as Timestamp,
      mockRoundEnd: data?['mockRoundEnd'] as Timestamp,
    );
  }

  factory Admin.fromMap(Map<String, dynamic> map) {
    return Admin(
      firstRoundEnd: map['firstRoundEnd'] as Timestamp,
      firstRoundStart: map['firstRoundStart'] as Timestamp,
      mockRoundEnd: map['mockRoundEnd'] as Timestamp,
      mockRoundStart: map['mockRoundStart'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory Admin.fromJson(String source) =>
      Admin.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Admin(firstRoundEnd: $firstRoundEnd, firstRoundStart: $firstRoundStart, mockRoundEnd: $mockRoundEnd, mockRoundStart: $mockRoundStart,  )';
  }

  // @override
  // bool operator ==(covariant Admin other) {
  //   if (identical(this, other)) return true;

  //   return other.password == password && other.email == email;
  // }

  @override
  int get hashCode {
    return firstRoundEnd.hashCode ^
        firstRoundStart.hashCode ^
        mockRoundEnd.hashCode ^
        mockRoundStart.hashCode;
  }
}
