import 'dart:convert';

class User {
  final int id;
  final String user_fname;
  final String user_lname;
  final String user_email;
  User({
    required this.id,
    required this.user_fname,
    required this.user_lname,
    required this.user_email,
  });

  User copyWith({
    int? id,
    String? user_fname,
    String? user_lname,
    String? user_email,
  }) {
    return User(
      id: id ?? this.id,
      user_fname: user_fname ?? this.user_fname,
      user_lname: user_lname ?? this.user_lname,
      user_email: user_email ?? this.user_email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_fname': user_fname,
      'user_lname': user_lname,
      'user_email': user_email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      user_fname: map['user_fname'] ?? '',
      user_lname: map['user_lname'] ?? '',
      user_email: map['user_email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, user_fname: $user_fname, user_lname: $user_lname, user_email: $user_email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.user_fname == user_fname &&
        other.user_lname == user_lname &&
        other.user_email == user_email;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user_fname.hashCode ^
        user_lname.hashCode ^
        user_email.hashCode;
  }
}
