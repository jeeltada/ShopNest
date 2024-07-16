import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String fullName;
  final String email;
  final String address;
  final String city;
  final String country;
  final String zipCode;

  const User({
    this.id,
    this.fullName = '',
    this.email = '',
    this.address = '',
    this.city = '',
    this.country = '',
    this.zipCode = '',
  });

  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? address,
    String? city,
    String? country,
    String? zipCode,
}){
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,

    );
  }


  // Factory method to create a User from a JSON object
  factory User.fromSnapshot(DocumentSnapshot snap) {
    return User(
      id: snap.id,
      fullName: snap['fullName'],
      email: snap['email'],
      address: snap['address'],
      city: snap['city'],
      country: snap['country'],
      zipCode: snap['zipCode'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'fullNmae': fullName,
      'email': email,
      'address': address,
      'city': city,
      'country': country,
      'zipCode' : zipCode,
    };
  }

  @override
  List<Object?> get props => [id, email, fullName, address, city, country, zipCode];

  // Method to convert a User to a JSON object

}
