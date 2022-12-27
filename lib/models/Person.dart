import 'dart:convert';

class Person {
  String user;
  String created;
  int id;
  String role;
  String username;
  String firstName;
  String middleName;
  String lastName;
  String dob;
  String email;
  String contactNumber;
  String address;
  String bloodGroup;
  String profilePicture;
  Person({
    required this.user,
    required this.created,
    required this.id,
    required this.role,
    required this.username,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.dob,
    required this.email,
    required this.contactNumber,
    required this.address,
    required this.bloodGroup,
    required this.profilePicture,
  });

  Person copyWith({
    String? user,
    String? created,
    int? id,
    String? role,
    String? username,
    String? firstName,
    String? middleName,
    String? lastName,
    String? dob,
    String? email,
    String? contactNumber,
    String? address,
    String? bloodGroup,
    String? profilePicture,
  }) {
    return Person(
      user: user ?? this.user,
      created: created ?? this.created,
      id: id ?? this.id,
      role: role ?? this.role,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      contactNumber: contactNumber ?? this.contactNumber,
      address: address ?? this.address,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'created': created,
      'id': id,
      'role': role,
      'username': username,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'dob': dob,
      'email': email,
      'contactNumber': contactNumber,
      'address': address,
      'bloodGroup': bloodGroup,
      'profilePicture': profilePicture,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      user: map['user'] ?? '',
      created: map['created'] ?? '',
      id: map['id']?.toInt() ?? 0,
      role: map['role'] ?? '',
      username: map['username'] ?? '',
      firstName: map['firstName'] ?? '',
      middleName: map['middleName'] ?? '',
      lastName: map['lastName'] ?? '',
      dob: map['dob'] ?? '',
      email: map['email'] ?? '',
      contactNumber: map['contactNumber'] ?? '',
      address: map['address'] ?? '',
      bloodGroup: map['bloodGroup'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Person(user: $user, created: $created, id: $id, role: $role, username: $username, firstName: $firstName, middleName: $middleName, lastName: $lastName, dob: $dob, email: $email, contactNumber: $contactNumber, address: $address, bloodGroup: $bloodGroup, profilePicture: $profilePicture)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Person &&
        other.user == user &&
        other.created == created &&
        other.id == id &&
        other.role == role &&
        other.username == username &&
        other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName &&
        other.dob == dob &&
        other.email == email &&
        other.contactNumber == contactNumber &&
        other.address == address &&
        other.bloodGroup == bloodGroup &&
        other.profilePicture == profilePicture;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        created.hashCode ^
        id.hashCode ^
        role.hashCode ^
        username.hashCode ^
        firstName.hashCode ^
        middleName.hashCode ^
        lastName.hashCode ^
        dob.hashCode ^
        email.hashCode ^
        contactNumber.hashCode ^
        address.hashCode ^
        bloodGroup.hashCode ^
        profilePicture.hashCode;
  }
}
