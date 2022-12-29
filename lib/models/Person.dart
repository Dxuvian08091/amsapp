// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  String gender;
  String dob;
  String email;
  String contactNumber;
  String address;
  String state;
  String district;
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
    required this.gender,
    required this.dob,
    required this.email,
    required this.contactNumber,
    required this.address,
    required this.state,
    required this.district,
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
    String? gender,
    String? dob,
    String? email,
    String? contactNumber,
    String? address,
    String? state,
    String? district,
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
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      contactNumber: contactNumber ?? this.contactNumber,
      address: address ?? this.address,
      state: state ?? this.state,
      district: district ?? this.district,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user,
      'created': created,
      'id': id,
      'role': role,
      'username': username,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'gender': gender,
      'dob': dob,
      'email': email,
      'contactNumber': contactNumber,
      'address': address,
      'state': state,
      'district': district,
      'bloodGroup': bloodGroup,
      'profilePicture': profilePicture,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      user: map['user'] as String,
      created: map['created'] as String,
      id: map['id'] as int,
      role: map['role'] as String,
      username: map['username'] as String,
      firstName: map['firstName'] as String,
      middleName: map['middleName'] as String,
      lastName: map['lastName'] as String,
      gender: map['gender'] as String,
      dob: map['dob'] as String,
      email: map['email'] as String,
      contactNumber: map['contactNumber'] as String,
      address: map['address'] as String,
      state: map['state'] as String,
      district: map['district'] as String,
      bloodGroup: map['bloodGroup'] as String,
      profilePicture: map['profilePicture'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) =>
      Person.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Person(user: $user, created: $created, id: $id, role: $role, username: $username, firstName: $firstName, middleName: $middleName, lastName: $lastName, gender: $gender, dob: $dob, email: $email, contactNumber: $contactNumber, address: $address, state: $state, district: $district, bloodGroup: $bloodGroup, profilePicture: $profilePicture)';
  }

  @override
  bool operator ==(covariant Person other) {
    if (identical(this, other)) return true;

    return other.user == user &&
        other.created == created &&
        other.id == id &&
        other.role == role &&
        other.username == username &&
        other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName &&
        other.gender == gender &&
        other.dob == dob &&
        other.email == email &&
        other.contactNumber == contactNumber &&
        other.address == address &&
        other.state == state &&
        other.district == district &&
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
        gender.hashCode ^
        dob.hashCode ^
        email.hashCode ^
        contactNumber.hashCode ^
        address.hashCode ^
        state.hashCode ^
        district.hashCode ^
        bloodGroup.hashCode ^
        profilePicture.hashCode;
  }
}
