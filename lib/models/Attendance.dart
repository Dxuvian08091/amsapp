import 'dart:convert';

class Attendance {
  int id;
  String person;
  String type;
  String date;
  String status;
  String latitude;
  String longitude;
  String entry;
  String exit;
  Attendance({
    required this.id,
    required this.person,
    required this.type,
    required this.date,
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.entry,
    required this.exit,
  });

  Attendance copyWith({
    int? id,
    String? person,
    String? type,
    String? date,
    String? status,
    String? latitude,
    String? longitude,
    String? entry,
    String? exit,
  }) {
    return Attendance(
      id: id ?? this.id,
      person: person ?? this.person,
      type: type ?? this.type,
      date: date ?? this.date,
      status: status ?? this.status,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      entry: entry ?? this.entry,
      exit: exit ?? this.exit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'person': person,
      'type': type,
      'date': date,
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
      'entry': entry,
      'exit': exit,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      id: map['id']?.toInt() ?? 0,
      person: map['person'] ?? '',
      type: map['type'] ?? '',
      date: map['date'] ?? '',
      status: map['status'] ?? '',
      latitude: map['latitude'] ?? '',
      longitude: map['longitude'] ?? '',
      entry: map['entry'] ?? '',
      exit: map['exit'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendance.fromJson(String source) =>
      Attendance.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Attendance(id: $id, person: $person, type: $type, date: $date, status: $status, latitude: $latitude, longitude: $longitude, entry: $entry, exit: $exit)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Attendance &&
        other.id == id &&
        other.person == person &&
        other.type == type &&
        other.date == date &&
        other.status == status &&
        other.latitude == latitude &&
        other.longitude == longitude &&
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
        latitude.hashCode ^
        longitude.hashCode ^
        entry.hashCode ^
        exit.hashCode;
  }
}
