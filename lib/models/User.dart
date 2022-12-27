import 'dart:convert';

class User {
  int id;
  String username;
  int profile;
  User({
    required this.id,
    required this.username,
    required this.profile,
  });

  User copyWith({
    int? id,
    String? username,
    int? profile,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      profile: profile ?? this.profile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'profile': profile,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      username: map['username'] ?? '',
      profile: map['profile']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(id: $id, username: $username, profile: $profile)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.username == username &&
        other.profile == profile;
  }

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ profile.hashCode;
}
