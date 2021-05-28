class User {
  final String firstName;
  final String lastName;
  final String result;

  const User({
    this.firstName,
    this.lastName,
    this.result,
  });

  User copy({
    String firstName,
    String lastName,
    String result,
  }) =>
      User(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        result: result ?? this.result,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          result == other.result;

  @override
  int get hashCode => firstName.hashCode ^ lastName.hashCode ^ result.hashCode;
}
