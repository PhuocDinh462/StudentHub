import 'package:equatable/equatable.dart';

enum UserType {
  student,
  company,
}

// Khai báo enum Role
enum Role { student, company }

class User extends Equatable {
  final int userId;
  final String fullName;
  // final String email;
  final Role role;
  final String token;

  // Constructor
  const User({
    required this.userId,
    required this.fullName,
    // required this.email,
    required this.role,
    required this.token,
  });

  @override
  List<Object?> get props => [userId, fullName, role, token];

  User copyWith({
    int? userId,
    String? fullName,
    // String? email,
    Role? role,
    String? token,
  }) {
    return User(
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      // email: email ?? this.email,
      role: role ?? this.role,
      token: token ?? this.token,
    );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'],
      fullName: map['fullName'],
      // email: map['email'],
      role: Role.values[map['role']],
      token: map['token'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullName': fullName,
      // 'email': email,
      'role': role.index,
      'token': token,
    };
  }
}
