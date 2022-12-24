class UserNotFoundAuthException implements Exception {}
class WrongPasswordAuthException implements Exception {}

// register
class WeakPasswordAuthException implements Exception {}
class EmailAlreadyInUserAuthException implements Exception {}
class InvalidEmailAuthException implements Exception {}

// generic user
class GenericAuthException implements Exception {}
class UserNotLoggedInAuthException implements Exception {}