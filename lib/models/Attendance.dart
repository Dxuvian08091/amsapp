// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Attendance {
  int id;
  String person;
  String type;
  String date;
  String status;
  String startLat;
  String startLong;
  String endLat;
  String endLong;
  String entry;
  String exit;
  Attendance({
    required this.id,
    required this.person,
    required this.type,
    required this.date,
    required this.status,
    required this.startLat,
    required this.startLong,
    required this.endLat,
    required this.endLong,
    required this.entry,
    required this.exit,
  });

  Attendance copyWith({
    int? id,
    String? person,
    String? type,
    String? date,
    String? status,
    String? startLat,
    String? startLong,
    String? endLat,
    String? endLong,
    String? entry,
    String? exit,
  }) {
    return Attendance(
      id: id ?? this.id,
      person: person ?? this.person,
      type: type ?? this.type,
      date: date ?? this.date,
      status: status ?? this.status,
      startLat: startLat ?? this.startLat,
      startLong: startLong ?? this.startLong,
      endLat: endLat ?? this.endLat,
      endLong: endLong ?? this.endLong,
      entry: entry ?? this.entry,
      exit: exit ?? this.exit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'person': person,
      'type': type,
      'date': date,
      'status': status,
      'startLat': startLat,
      'startLong': startLong,
      'endLat': endLat,
      'endLong': endLong,
      'entry': entry,
      'exit': exit,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      id: map['id'] as int,
      person: map['person'] as String,
      type: map['type'] as String,
      date: map['date'] as String,
      status: map['status'] as String,
      startLat: map['startLat'] as String,
      startLong: map['startLong'] as String,
      endLat: map['endLat'] as String,
      endLong: map['endLong'] as String,
      entry: map['entry'] as String,
      exit: map['exit'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendance.fromJson(String source) =>
      Attendance.fromMap(json.decode(source) as Map<String, dynamic>);

  static String encode(List<Attendance> q) =>
      jsonEncode(q.map<Map<String, dynamic>>((item) => item.toMap()).toList());

  static List<Attendance> decode(String attendances) =>
      (jsonDecode(attendances) as List<dynamic>)
          .map<Attendance>((item) => Attendance.fromMap(item))
          .toList();

  @override
  String toString() {
    return 'Attendance(id: $id, person: $person, type: $type, date: $date, status: $status, startLat: $startLat, startLong: $startLong, endLat: $endLat, endLong: $endLong, entry: $entry, exit: $exit)';
  }

  @override
  bool operator ==(covariant Attendance other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.person == person &&
        other.type == type &&
        other.date == date &&
        other.status == status &&
        other.startLat == startLat &&
        other.startLong == startLong &&
        other.endLat == endLat &&
        other.endLong == endLong &&
        other.entry == entry &&
        other.exit == exit;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        person.hashCode ^
        type.hashCode ^
        date.hashCode ^
        status.hashCode ^
        startLat.hashCode ^
        startLong.hashCode ^
        endLat.hashCode ^
        endLong.hashCode ^
        entry.hashCode ^
        exit.hashCode;
  }
}
