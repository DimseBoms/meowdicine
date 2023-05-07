class User {
  final int id = 0;
  final String username;
  final String sessionId;

  const User({required this.username, required this.sessionId});

  // Converts user to a map, with keys matching the database columns
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'sessionId': sessionId,
    };
  }

  // Converts map to a user, with keys matching the database columns
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      sessionId: map['sessionId'],
    );
  }

  // Converts user to a JSON object, for use with the backend API
  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      sessionId: json['sessionId'],
    );
  }

  @override
  String toString() {
    return 'User{id: $id, name: $username sessionId: $sessionId}';
  }
}
