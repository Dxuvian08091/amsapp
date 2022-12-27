import 'dart:convert';

class Role {
  int id;
  String role;
  Role({
    required this.id,
    required this.role,
  });

  Role copyWith({
    int? id,
    String? role,
  }) {
    return Role(
      id: id ?? this.id,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role,
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    return Role(
      id: map['id']?.toInt() ?? 0,
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Role.fromJson(String source) => Role.fromMap(json.decode(source));

  @override
  String toString() => 'Role(id: $id, role: $role)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Role && other.id == id && other.role == role;
  }

  @override
  int get hashCode => id.hashCode ^ role.hashCode;
}
