class User {
  final int id = 0;
  final String name;
  final String email;
  final String sessionId;

  const User(
      {required this.name, required this.email, required this.sessionId});

  // Converts user to a map, with keys matching the database columns
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'sessionId': sessionId,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, sessionId: $sessionId}';
  }
}
